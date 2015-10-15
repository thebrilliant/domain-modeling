//
//  UnitTests.swift
//  Domain-Modeling
//
//  Created by Vivyan Woods on 10/15/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import XCTest
@testable import Domain-Modeling//.main.swift

class UnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        var mon1 = Money(amt: 73500.0, cur: "USD")
        var mon4 = Money(amt: 500.0, cur: "USD")
        var mon2 = Money(amt: 5763053.9, cur: "GBP")
        var mon3 = Money(amt: 3525.0, cur: "Yen")
        switch mon3.currency {
            case "USD", "GBP", "EUR", "CAN":
            print("test passed")
        default:
            print("test failed")
        }
        var result = mon1.add(mon4)
        switch result.amount {
        case 74000.0:
            print("test passed")
        default:
            print("test failed")
        }
        var res = mon1.sub(mon4)
        switch res.amount {
        case 73000.0:
            print("test passed")
        default:
            print("test failed")
        }
        
        //var job1 = Job(title: "Captain", sal: "73000 USD yr")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
