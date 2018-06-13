//
//  UserResponse.swift
//  LogIn
//
//  Created by Insharp on 3/21/17.
//  Copyright © 2017 Insharp. All rights reserved.
//
import Foundation
import ObjectMapper

class UserResponse: Mappable {
    var meta: Meta?
    var user: User?
    var errors: Errors?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        meta <- map["meta"]
        user <- map["data"]
        errors <- map["errors"]
    }
}
class Meta: Mappable {
    var code: Int?
    var message: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
class ResendEmailUserResponse: Mappable {
    var meta: Meta?
    var user: User?
    var errors: Errors?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        meta <- map["meta"]
        user <- map["data"]
        errors <- map["errors"]
    }
}

class User: Mappable {
    
    var id: Int?
    var name: String?
    var email: String?
    var api_token: String?
    var password: String?
    var password_confirmation: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        api_token <- map["api_token"]
        password <- map["password"]
        password_confirmation <- map["password_confirmation"]
    }
}

class Errors: Mappable {
    var id: [Int]?
    var name: [String]?
    var email: [String]?
    var api_token: [String]?
    var password: [String]?
    var password_confirmation: [String]?
    
    required init?(map: Map) {        
    }
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        api_token <- map["api_token"]
        password <- map["password"]
        password_confirmation <- map["password_confirmation"]
    }
}
