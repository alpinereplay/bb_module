//
//  RouteHandlerTests.swift
//  bb_module
//
//  Created by Brian Bal on 8/14/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
@testable import bb_module

class TestRoute : Route {
    var userId : Int64
    
    init(_ path: String, userId: Int64) {
        self.userId = userId
        super.init(path)
    }
}

class RouteHandlerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init() {
        // This is an example of a functional test case.
        let handler = RouteHandler(path: "/path/*", exact: false) { route in
            return true
        }
        
        XCTAssertNotNil(handler)
        XCTAssertEqual("/path/*", handler.path)
    }
    
    func test_canHandleRoute() {
        let handler = RouteHandler(path: "/path/to/*", exact: false) { route in
            return true
        }
        let test1 = handler.canHandle(Route("/path/to/test1"))
        let test2 = handler.canHandle(Route("/path/to/"))
        let test3 = handler.canHandle(Route("/path/fail/test3"))
        let test4 = handler.canHandle(Route("/"))
        
        XCTAssertTrue(test1)
        XCTAssertTrue(test2)
        XCTAssertFalse(test3)
        XCTAssertFalse(test4)
    }
    
    func test_handleRoute() {
        var test1 = false
        let handler = RouteHandler(path: "/path/to/*", exact: false) { route in
            test1 = true
            return true
        }
        
        let ret = handler.handle(Route("/path/to/test1"))
        
        XCTAssertTrue(ret);
        XCTAssertTrue(test1)
    }
    
    func test_handleRoute_customType() {
        var test1 = false
        var userId : Int64 = 0;
        let handler = RouteHandler(path: "/path/to/*", exact: false) { route in
            test1 = true
            if let testRoute = route as? TestRoute {
                userId = testRoute.userId
                return true
            }
            return false
        }
        
        let ret = handler.handle(TestRoute("/path/to/test1", userId: 199))
        
        XCTAssertTrue(ret);
        XCTAssertTrue(test1)
        XCTAssertEqual(199, userId)
    }
    
    func test_handleRoute_customTypeNotProvided() {
        var test1 = false
        var userId : Int64 = 0;
        let handler = RouteHandler(path: "/path/to/*", exact: false) { route in
            test1 = true
            if let testRoute = route as? TestRoute {
                userId = testRoute.userId
                return true
            }
            return false
        }
        
        let ret = handler.handle(Route("/path/to/test1"))
        
        XCTAssertFalse(ret);
        XCTAssertTrue(test1)
        XCTAssertEqual(0, userId)
    }
    
}
