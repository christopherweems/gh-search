//  Wrappable+Extensions.swift
//  Created by Christopher Weems on 8/20/2.

import unstandard

internal extension Wrappable {
    func assert(_ condition: (Self) -> Bool, _ message: @autoclosure () -> String = .init(),
                file: StaticString = #file, line: UInt = #line) -> Self {
        Swift.assert(condition(self), message())
        return self
    }
    
}
