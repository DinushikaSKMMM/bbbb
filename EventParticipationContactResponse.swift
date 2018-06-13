//
//  EventParticipationContactResponse.swift
//  LogIn
//
//  Created by Insharp on 6/27/17.
//  Copyright © 2017 Insharp. All rights reserved.
//

import Foundation
import ObjectMapper

class EventParticipationContactResponse: Mappable {
    var meta: EventParticipationMeta?
    var Event_Details: [Event_Details]?
    var errors: EventParticipationErrors?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        meta <- map["meta"]
        Event_Details <- map["data"]
        errors <- map["errors"]
    }
}
class EventParticipationMeta: Mappable {
    var code: Int?
    var message: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
//class EventParticipation: Mappable {
//    var ParticipationContact: [ParticipationContact]?
//    required init?(map: Map) {    }
//    
//    func mapping(map: Map) {
//        ParticipationContact <- map["data"]
//    }
//}
//class EventDetails: Mappable {
//    var id: Int?
//    var eventName: String?
//    var eventDescription: String?
//    var eventLocation: String?
//    var eventStartTime: String?
//    var eventEndTime: String?
//    var user_id: Int?
//    var corperation_id:Int?
//    var locationLongitude: Double?
//    var locationLatitude: Double?
//    required init?(map: Map) {    }
//    
//    func mapping(map: Map) {
//        id <- map["id"]
//        eventName <- map["name"]
//        eventDescription <- map["description"]
//        eventLocation <- map["location"]
//        eventStartTime<-map["start_date"]
//        eventEndTime <- map["end_date"]
//        user_id <- map["user_id"]
//        corperation_id <- map["corperation_id"]
//        locationLongitude <- map["longitude"]
//        locationLatitude <- map["latitude"]
//    }
//}

class Event_Details: Mappable {
    var id: Int?
    var eventName: String?
    var eventDescription: String?
    var eventLocation: String?
    var eventStartTime: String?
    var eventEndTime: String?
    var user_id: Int?
    var corperation_id:Int?
    var locationLongitude: Double?
    var locationLatitude: Double?
    var ParticipationUsersDetails:[ParticipationUsersDetails]?
    required init?(map: Map) {    }
    
    func mapping(map: Map) {
        id <- map["id"]
        eventName <- map["name"]
        eventDescription <- map["description"]
        eventLocation <- map["location"]
        eventStartTime<-map["start_date"]
        eventEndTime <- map["end_date"]
        user_id <- map["user_id"]
        corperation_id <- map["corperation_id"]
        locationLongitude <- map["longitude"]
        locationLatitude <- map["latitude"]
        ParticipationUsersDetails <- map["participation_users"]
    }
}
//class participationContactUsers: Mappable {
//    var id: Int?
//    var user_id: Int?
//    var contact_user_id: Int?
//    var contact_user: [contact_user]?
//    
//    required init?(map: Map) {
//    }
//    func mapping(map: Map) {
//        id <- map["id"]
//        user_id <- map["user_id"]
//        contact_user_id <- map["contact_user_id"]
//        contact_user <- map["contact_user"]
//
//    }
//}
class ParticipationUsersDetails: Mappable {
    var id: Int?
    var name: String?
    var email: String?
    var designation: String?
    var profile_url: String?
    //var corperation: corperation?
    var contacts: [contacts]?
    var contact_user_id: Int?   // var phoneNo: String?
    var user_id: Int?
    var corperationDetails: corperationDetails?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        designation <- map["designation"]
        profile_url<-map["profile_url"]
        contacts <- map["contacts"]
        contact_user_id<-map["contact_user_id"]
        user_id <- map["registration_id"]
        corperationDetails <- map["corperation"]
        //phones <- map["phones"]
    }
}
class corperationDetails: Mappable {
    var id: Int?
    var companyName: String?
    var companyAddress: String?
    var img: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        companyName <- map["name"]
        companyAddress <- map["address"]
        img <- map["logo"]
    }
}

class contacts: Mappable {
    var id : Int?
    var name: String?
    var email: String?
    var designation: String?
    var registration_id: Int?
    var corperation_id: Int?
    var profile_url: String?
    var contact_user_id: String?
    
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        designation <- map["designation"]
        profile_url <- map["profile_url"]
        corperation_id<-map["corperation_id"]
        registration_id<-map["registration_id"]
    }
}


class EventParticipationErrors: Mappable {
    var id: Int?
    var eventName: String?
    var eventDescription: String?
    var eventLocation: String?
    var eventStartTime: String?
    var eventEndTime: String?
    var user_id: Int?
    var corperation_id:Int?
    var locationLongitude: Double?
    var locationLatitude: Double?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        id <- map["id"]
        eventName <- map["name"]
        eventDescription <- map["description"]
        eventLocation <- map["location"]
        eventStartTime<-map["start_date"]
        eventEndTime <- map["end_date"]
        user_id <- map["user_id"]
        corperation_id <- map["corperation_id"]
        locationLongitude <- map["longitude"]
        locationLatitude <- map ["latitude"]
        
    }
}
