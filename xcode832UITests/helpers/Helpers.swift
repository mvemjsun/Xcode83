//
//  Helpers.swift
//  xcode832UITests
//
//  Created by mvemjsun on 12/06/2017.
//  Copyright © 2017 NowTV. All rights reserved.
//

import Foundation
import XCTest

extension XCTest {
    
    func Given(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
    
    func When(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
    
    func Then(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
    
    func step(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
    
    func And(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
    
    func But(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: #function + " " + text) { _ in
            step()
        }
    }
}
