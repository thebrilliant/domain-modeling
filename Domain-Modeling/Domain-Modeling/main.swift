//
//  main.swift
//  Domain-Modeling
//
//  Created by Vivyan Woods on 10/13/15.
//  Copyright © 2015 Vivyan Woods. All rights reserved.
//

import Foundation

print("Hello, World!")
//print("TESTING!!!")
print("We're gonna make some money, jobs, people and families")
print("")

protocol Mathematics {
    func add(other: Money)
    func sub(other: Money)
}

extension Double {
    var USD: Money {return Money(amt: self, cur: "USD")}
    var GBP: Money {return Money(amt: self, cur: "GBP")}
    var EUR: Money {return Money(amt: self, cur: "EUR")}
    var YEN: Money {return Money(amt: self, cur: "YEN")}
}

class Money : CustomStringConvertible, Mathematics {
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
    
    var description: String {
        return "\(amount)\(currency)"
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
    
    func add(other: Money) {
        if other.currency != self.currency {
            other.convert(self.currency)
        }
        var total = 0.0
        total = self.amount + other.amount
        //print("\(total) \(self.currency)")
        self.amount = total
    }
    
    func addWithReturn(other: Money) -> Money {
        self.add(other)
        return Money(amt: amount, cur: currency)
    }
    
    func sub(other: Money) {
        if other.currency != self.currency {
            other.convert(self.currency)
        }
        var total = 0.0
        total = self.amount - other.amount
        //print("\(total) \(self.currency)")
        self.amount = total
    }
    
    func subWithReturn(other: Money) -> Money {
        self.sub(other)
        return Money(amt: amount, cur: currency)
    }
}

func makeMoney() {
    var mon1 = Money(amt: 16.07, cur: "USD")
    let mon2 = Money(amt: 73500.0, cur: "EUR")
    let mon3 = Money(amt: 42.0, cur: "CAN")
    let mon4 = Money(amt: 13.0, cur: "GBP")
    
    print("Money Description Unit Tests:")
    print("Expected: 16.07USD")
    print("Actual: \(mon1.description)")
    print("Expected: 73500.0EUR")
    print("Actual: \(mon2.description)")
    print("Expected: 42.0CAN")
    print("Actual: \(mon3.description)")
    print("Expected: 13.0GBP")
    print("Actual: \(mon4.description)")
    
    let mon5 = Money(amt: 10.22, cur: "USD")
    print("Money + - Unit Tests:")
    print("Add: 10.22 + 16.07 USD")
    print("Expected: 26.29USD")
    mon1.add(mon5)
    print("Actual: \(mon1.description)")
    print("Subtract: 26.29 - 10.22 USD")
    print("Expcted: 16.07USD")
    mon1.sub(mon5)
    print("Actual: \(mon1.description)")
    
    print("Double Extension Money Unit Tests:")
    let amt = 15.09
    print("I have \(amt) in:")
    print(amt.USD.description)
    print(amt.EUR.description)
    print(amt.GBP.description)
    print(amt.YEN.description)
}

makeMoney()

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
            print(currYear)
            print("currency: " + currency)
            currYear = currYear.substringFromIndex(currYear.rangeOfString(" ")!.endIndex)
            salary = Money(amt: temp, cur: currency)
            hourYear = currYear
        } else {
            //assume sal to be per year if in format: 75000 USD
            let temp = Double(sal.substringToIndex(sal.rangeOfString(" ")!.startIndex))!
            var currYear = sal.substringFromIndex(sal.rangeOfString(" ")!.endIndex)
            var currency = currYear.substringToIndex(currYear.rangeOfString(" ")!.startIndex)
            print(currYear)
            print("currency: " + currency)
            currYear = currYear.substringFromIndex(currYear.rangeOfString(" ")!.endIndex)
            print("currency and yearly: \(currYear)")
            salary = Money(amt: temp, cur: currYear)
            hourYear = "year"
        }
    }
    
    func calculateIncome(var numHours: Int?) -> Double {
        if numHours == nil {
            if hourYear.containsString("y") {
                print("\(salary.amount) / year")
                return salary.amount
            } else {
                //assumed no hours worked
                numHours = 0
            }
        }
        print("\(salary.amount * (Double(numHours!) * 52)) / year")
        return salary.amount * (Double(numHours!) * 52)
    }
    
    func raise(percent: Double) {
        salary = salary.addWithReturn(Money(amt: (salary.amount * percent), cur: salary.currency))
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
    
    init (fName: String, lName: String, age: Int, occ: Job?, sO: Person?) {
        firstName = fName
        lastName = lName
        self.age = age
        job = occ
        if age < 16 {
            print("YOU CAN'T HAVE A JOB")
            job = nil
        }
        spouse = sO
        if age < 18 {
            print("YOU CAN'T BE MARRIED! WAIT UNTIL YOU'RE OLDER!")
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
        print("congratulations! your family had a baby")
        family.append(Person())
    }
}


var mon1 = Money(amt: 73500.0, cur: "USD")
var mon2 = Money(amt: 5763053.9, cur: "GBP")
var mon3 = Money(amt: 3525.0, cur: "Yen")
var mon4 = Money(amt: 500.0, cur: "USD")

switch mon3.currency {
case "USD", "GBP", "EUR", "CAN":
    print("test passed")
default:
    print("test failed")
}

var result = mon1.addWithReturn(mon4)
switch result.amount {
case 74000.0:
    print("test passed")
default:
    print("test failed")
}
var res = mon1.subWithReturn(mon4)
switch res.amount {
case 73000.0:
    print("test passed")
default:
    print("test failed")
}

var newRes = result.addWithReturn(mon2)
var newRes2 = result.subWithReturn(mon2)

newRes.convert("EUR")

var job1 = Job(title: "Sleuth", sal: "73000 USD /yr")
var job2 = Job(title: "Lab Assistant", sal: "10 USD /hr")
var job3 = Job(title: "TA", sal: "13 USD /hr")
var job4 = Job(title: "Captain", sal: "1000 EUR hr")
var job5 = Job(title: "Hero", sal: "100000 CAN yr")

var jobs = [job1, job2, job3, job4, job5]
for job in jobs {
    print("\(job.title) makes:")
    print(job.calculateIncome(40))
    job.raise(0.01)
    print("salaray after 1% raise:")
    print("\(job.salary.amount) or \(job.calculateIncome(40))")
}


var person1 = Person(fName: "L", lName: "Ryuzaki", age: 21, occ: job1, sO: nil)
var person2 = Person(fName: "Light", lName: "Yagami", age: 19, occ: job3, sO: person1)
person1.spouse = person2
var person3 = Person(fName: "Daiki", lName: "Aomine", age: 16, occ: job4, sO: nil)
var person4 = Person(fName: "Taiga", lName: "Kagami", age: 15, occ: job4, sO: person3)

var family1 = Family(fam: [person1, person2])
var family2 = Family(fam: [person3, person4])
family1.haveBaby()
print("household income: \(family1.householdIncome())")
for person in family1.family {
    print(person.toString())
}

for person in family2.family {
    print(person.toString())
}