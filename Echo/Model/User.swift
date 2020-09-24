//
//  model.swift
//  Echo
//
//  Created by Kasito on 21.09.2020.
//

import Foundation

struct ResponseObject<T: Codable>: Codable {
    var success: Bool
    var data: T?
    var errors: [APIError]?
}

struct User: Codable {
    var uid: Int?
    var name: String?
    var email: String?
    var access_token: String?
    var role: Int?
    var status: Int?
    var created_at: Int?
    var updated_at: Int?
}

struct APIError: Codable {
    var name: String?
    var message: String?
    var code: Int?
    var status: Int?
    var field: String?
}
