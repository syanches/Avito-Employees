//
//  Employee.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

struct Employee {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    static func EmployeesMock() -> [Employee] {
        return [
            Employee(name: "John", phoneNumber: "769453", skills: ["Swift", "iOS"]),
            Employee(name: "Diego", phoneNumber: "987924", skills: ["Kotlin", "Android"]),
            Employee(name: "Alfred", phoneNumber: "452533", skills: ["Objective-C", "Android", "Photoshop", "Objective-C", "Android"]),
            Employee(name: "John", phoneNumber: "212456", skills: ["Java", "Python"]),
            Employee(name: "Mat", phoneNumber: "778975", skills: ["Android", "MovieMaker"]),
            Employee(name: "Bob", phoneNumber: "456468", skills: ["Groovy", "Kotlin"]),
            Employee(name: "Marty", phoneNumber: "321789", skills: ["Android", "PHP", "C#"]),
        ]
    }
}
