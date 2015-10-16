//
//  UnitTests.swift
//  Domain-Modeling
//
//  Created by Vivyan Woods on 10/15/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//
/*
import XCTest
//@testable import Domain-Modeling//.main.swift

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
        
        var newRes = result.add(mon2)
        var newRes2 = result.sub(mon2)
        var test9 = res.add(mon2)
        var tes10 = res.sub(mon2)
        
        var job1 = Job(title: "Captain", sal: "73000 USD yr")
        var job2 = Job(title: "Lab Assistant", sal: "10 USD hr")
        var job3 = Job(title: "TA", sal: "13 USD hr")
        var job4 = Job(title: "Coach", sal: "1000 EUR hr")
        var job5 = Job(title: "Hero", sal: "100000 CAN yr")
        
        var jobs = [job1, job2, job3, job4, job5]
        for job in jobs {
            print("\(job.title) makes:")
            print(job.calculateIncome(40))
            job.raise(0.01)
            print("salaray after 1% raise:")
            print("\(job.salary.amount) or \(job.calculateIncome(40))")
        }
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

}*/
