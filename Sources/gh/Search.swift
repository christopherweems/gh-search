//  Search.swift
//  Created by Christopher Weems on 4/2/21

import ArgumentParser
import GHSearch
import Foundation

@main
struct Search: ParsableCommand {
    private static let knownRepositories = KnownRepositories(platform: .github)
    
    @Argument(help: "The name of the GitHub repository to search for")
    var repositoryName: String
    
    @Flag(help: "Ignore known redirect for well known repositories")
    var disableKnownRepositoryRedirect = false
    private var allowKnownRepositoryRedirect: Bool { !disableKnownRepositoryRedirect }
    
    mutating func run() throws {
        let url: URL
        
        if allowKnownRepositoryRedirect, let knownURL = Self.knownRepositories[repositoryName] {
            url = knownURL
            
        } else if let repositorySearchURL = self.repositorySearchURL {
            url = repositorySearchURL
            
        } else {
            throw URLError(.badURL)
            
        }
        
        Workspace.shared.open(url)
        
    }
    
}

private extension Search {
    var repositorySearchURL: URL? {
        repositoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .map { "https://github.com/search?q=\($0)&type=repositories" }
            .flatMap { URL(string: $0) }
    }
    
}
