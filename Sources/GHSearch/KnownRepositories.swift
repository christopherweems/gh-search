//  KnownRepositories.swift
//  Created by Christopher Weems on 4/2/21

import Algorithms
import Foundation
import Resultto
import unstandard

public struct KnownRepositories {
    public enum Platform: String {
        case github = "GitHub"
        
    }
    
    private let repositoryPaths: [String : String]
    
    @SingleResult public subscript(query: String) -> URL? {
        let normalizedQuery = query.lowercased()
        
        repositoryPaths[normalizedQuery]
            .flatMap { URL(string: "https://github.com" + $0) }
    }
    
    public init(platform: Platform) {
        precondition(platform == .github, "Only GitHub platform is currently supported")
        self.repositoryPaths = Self.repositoryPaths(for: platform)
        
    }
    
    public init(repositoryPathsFileURL: URL) {
        self.repositoryPaths = Self.repositoryPaths(for: repositoryPathsFileURL)
        
    }
    
}

private extension KnownRepositories {
    static func repositoryPaths(for platform: Platform) -> [String : String] {
        Bundle.module.url(forResource: platform.rawValue, withExtension: "txt")
            .map { repositoryPaths(for: $0) } ?? [:]
    }
    
    static func repositoryPaths(for pathFileURL: URL) -> [String : String] {
        precondition(pathFileURL.pathExtension == "txt")
        
        let repositoryPaths = try? pathFileURL
            .wrap { try Data(contentsOf: $0) }
            .wrap { String(data: $0, encoding: .utf8) }
            .flatMap { $0.components(separatedBy: .newlines) }?
            .filter { !$0.isEmpty && !$0.hasPrefix("//") }
        
        return repositoryPaths?
            .map { ($0.index(afterLastIndexOf: "/") ?? $0.startIndex, $0) }
            .map { ($1, $1.suffix(from: $0).asString()) }
            .assert({ $0.allUnique(on: \.0) }, "duplicate repositories exist in paths file")
            .wrap { Dictionary(uniqueValuesWithKeys: $0) } ?? [:]
    }
    
}
