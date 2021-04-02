//  KnownRepositories.swift
//  Created by Christopher Weems on 4/2/21

import Foundation
import Resultto

public struct KnownRepositories {
    public enum Platform {
        case github
        
    }
    
    private let platform: Platform
    
    @SingleResult public subscript(query: String) -> URL? {
        let normalizedQuery = query.lowercased()
        
        switch platform {
        case .github:
            Self.gitHubRepositoryPaths[normalizedQuery]
                .flatMap { URL(string: "https://github.com" + $0) }
            
        }
    }
    
    public init(platform: Platform) {
        precondition(platform == .github, "Only GitHub platform currently supported")
        self.platform = platform
        
    }
    
}

private extension KnownRepositories {
    static let gitHubRepositoryPaths = [
        "swift" : "/apple/swift",
        "swift-algorithms" : "/apple/swift-algorithms",
        "swift-argument-parser" : "/apple/swift-argument-parser",
        "swift-atomics" : "/apple/swift-atomics",
        "swift-crypto" : "/apple/swift-crypto",
        "swift-driver" : "/apple/swift-driver",
        "swift-evolution" : "/apple/swift-evolution",
        "swift-format" : "/apple/swift-format",
        "swift-log" : "/apple/swift-log",
        "swift-http-structured-headers" : "/apple/swift-http-structured-headers",
        "swift-nio" : "/apple/swift-nio",
        "swift-nio-extras" : "/apple/swift-nio-extras",
        "swift-nio-ssl" : "/apple/swift-nio-ssl",
        "swift-nio-http2" : "/apple/swift-nio-http2",
        "swift-numerics" : "/apple/swift-numerics",
        "swift-metrics" : "/apple/swift-metrics",
        "swift-syntax" : "/apple/swift-syntax",
        "swift-system" : "/apple/swift-system",
        
        "bonanas" : "/christopherweems/bonanas",
        "resultto" : "/christopherweems/Resultto",
        "unstandard" : "/christopherweems/unstandard"
    ]
    
}
