//
//  LocalUser.swift
//  Created by GaliSrikanth on 06/05/25.


import Foundation

struct LocalUser: Codable {
    var uid: String
    var email: String
    var fullName: String
    var phoneNum: String?
}
