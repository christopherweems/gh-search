//  Workspace.swift
//  Created by Christopher Weems on 4/2/21

#if canImport(AppKit)
import AppKit
#endif

public struct Workspace {
    public static let shared = Self()
    
    public func open(_ url: URL) {
        #if canImport(AppKit)
        NSWorkspace.shared.open(url)
        
        #else
        fatalError("Workspace not implemented for this operating system")
        
        #endif
    }
    
    private init() {
        
    }
    
}
