//  Search.swift
//  Created by Christopher Weems on 4/2/21

import ArgumentParser
import GHSearch
import Foundation

@main
struct Search: ParsableCommand {
    private lazy var knownRepositories: KnownRepositories = {
        if let knownRepositoriesPathURL = self.knownRepositoriesPath.flatMap(URL.init(fileURLWithPath:)) {
            return KnownRepositories(repositoryPathsFileURL: knownRepositoriesPathURL)
            
        } else {
            return KnownRepositories(platform: .github)
        }
    }()
    
    public static let configuration = CommandConfiguration(
        commandName: "gh"
    )
    
    @Argument(help: "The name of the GitHub repository to find")
    var repositoryName: String
    
    @Flag(help: "Ignore known redirect for well known repositories.")
    var disableKnownRepositoryRedirect = false
    private var allowKnownRepositoryRedirect: Bool { !disableKnownRepositoryRedirect }
    
    @Option(help: "The path of your known repositories text file")
    var knownRepositoriesPath: String?
    
    mutating func run() throws {
        let url: URL
        
        if allowKnownRepositoryRedirect, let knownURL = knownRepositories[repositoryName] {
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
