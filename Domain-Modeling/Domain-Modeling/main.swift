//
//  main.swift
//  Domain-Modeling
//
//  Created by Vivyan Woods on 10/13/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation

print("Hello, World!")

class Money {
    var amount : Double
    var currency : String
    
    init (amt: Double, var cur: String) {
        amount = amt
        cur = cur.uppercaseString
        switch cur {
        case "USD", "GBP", "EUR", "CAN":
            let temp = cur
        default:
            print("Woah, it has to be USD, GBP, EUR, or CAN")
            print("I choose it to be USD")
            cur = "USD"
        }
        currency = cur
    }
    
    func convert(var cur: String) {
        switch cur {
        case "USD", "GBP", "EUR", "CAN":
            let temp = cur
        default:
            print("Woah, it has to be USD, GBP, EUR, or CAN")
            print("I choose it to be USD")
            cur = "USD"
        }
        switch currency {
        case "USD":
            switch cur {
            case "GBP":
                amount = amount * 0.5
                currency = cur
            case "EUR":
                amount = amount * 1.5
                currency = cur
            case "CAN":
                amount = amount * 1.25
                currency = cur
            default:
                print("whoops something went wrong")
            }
        case "GBP":
            switch cur {
            case "USD":
                amount = amount * 2.0
                currency = cur
            case "EUR":
                amount = amount * 3.0
                currency = cur
            case "CAN":
                amount = amount * 2.5
                currency = cur
            default:
                print("whoops something went wrong")
            }
        case "EUR":
            switch cur {
            case "USD":
                amount = amount / 1.5
                currency = cur
            case "GBP":
                let tempAmount = amount / 1.5
                amount = tempAmount * 0.5
                currency = cur
            case "CAN":
                let tempAmount = amount / 1.5
                amount = tempAmount * 1.25
                currency = cur
            default:
                print("whoops something went wrong")
            }
        case "CAN":
            switch cur {
            case "USD":
                amount = amount * 0.8
                currency = cur
            case "GBP":
                let tempAmount = amount * 0.8
                amount = tempAmount * 0.5
                currency = cur
            case "EUR":
                let tempAmount = amount * 0.8
                amount = tempAmount * 1.5
                currency = cur
            default:
                print("whoops something went wrong")
            }
        default:
            print("whoops, something went wrong")
        }
    }
    
    private func convertToUSD(amt: Double, cur: String) {
        
    }
    
    func add(other: Money) -> Money {
        if other.currency != self.currency {
            other.convert(self.currency)
        }
        var total = 0.0
        total = self.amount + other.amount
        
        return Money(amt: total, cur: self.currency)
    }
    
    func sub(other: Money) -> Money{
        if other.currency != self.currency {
            other.convert(self.currency)
        }
        var total = 0.0
        total = self.amount - other.amount
        
        return Money(amt: total, cur: self.currency)
    }
}

class Job {
    let title: String
    var salary: Money
    let hourYear: String
    
    init (title: String, sal: String) {
        self.title = title
        //assume value of sal to be in format: 75000 USD /yr
        if sal.containsString("/") {
            let temp = Double(sal.substringToIndex(sal.rangeOfString(" ")!.startIndex))!
            var currYear = sal.substringFromIndex(sal.rangeOfString(" ")!.endIndex)
            var currency = currYear.substringToIndex(currYear.rangeOfString(" ")!.startIndex)
            currYear = currYear.substringFromIndex(currYear.rangeOfString(" ")!.endIndex)
            salary = Money(amt: temp, cur: currency)
            hourYear = currYear
        } else {
            //assume sal to be per year if in format: 75000 USD
            let temp = Double(sal.substringToIndex(sal.rangeOfString(" ")!.startIndex))!
            var currYear = sal.substringFromIndex(sal.rangeOfString(" ")!.endIndex)
            salary = Money(amt: temp, cur: currYear)
            hourYear = "year"
        }
    }
    
    func calculateIncome(var numHours: Int?) -> Double {
        if numHours == nil {
            if hourYear.containsString("y") {
                //print("\(salary) / year")
                return salary.amount
            } else {
                //assumed no hours worked
                numHours = 0
            }
        }
        //print("\(salary * Double(numHours!)) / year")
        return salary.amount * Double(numHours!)
    }
    
    func raise(percent: Double) {
        salary = salary.add(Money(amt: (salary.amount * percent), cur: salary.currency))
    }
}

class Person {
    let firstName: String
    let lastName: String
    let age: Int
    var job: Job?
    var spouse: Person?
    
    init () {
        firstName = ""
        lastName = ""
        age = 0
    }
    
    init (fName: String, lName: String, age: Int, occ: Job, sO: Person) {
        firstName = fName
        lastName = lName
        self.age = age
        job = occ
        if age < 16 {
            job = nil
        }
        spouse = sO
        if age < 18 {
            spouse = nil
        }
    }
    
    func toString() -> String {
        var result = "\(firstName) \(lastName) is \(age) years old"
        if job != nil {
            result += (", works as " + (job?.title)!)
        }
        if spouse != nil {
            result += (", and is married to \((spouse?.firstName)!) \((spouse?.lastName)!)")
        }
        
        return result
    }
}

class Family {
    var family: [Person]
    
    init (fam: [Person]) {
        var isValid = false
        for person in fam {
            if person.age >= 21 {
                isValid = true
            }
        }
        if !isValid {
            //throw exception??
            print("this family is illegal")
        }
        family = fam
    }
    
    func householdIncome() -> Double {
        var total = 0.0
        for person in family {
            if person.job != nil {
                total += (person.job?.calculateIncome(nil))!
            }
        }
        
        return total
    }
    
    func haveBaby() {
        family.append(Person())
    }
}


