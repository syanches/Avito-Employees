//
//  Employee.swift
//  Avito-Employees
//
//  Created by Artem Martirosyan on 26.10.2022.
//

import UIKit

struct Employee: Decodable {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}

struct Company: Decodable {
    let name: String
    let employees: [Employee]
}

struct CompanyItem: Decodable {
    let company: Company
}
