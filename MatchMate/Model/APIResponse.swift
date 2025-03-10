//
//  APIResponse.swift
//  MatchMate
//
//  Created by Mansi Laad on 13/02/25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userResponse = try? JSONDecoder().decode(UserResponse.self, from: jsonData)

import Foundation

// // MARK: - UserResponse
 struct UserResponse: Codable {
     let results: [Result]
     let info: Info
 }

 // MARK: - Info
 struct Info: Codable {
     let seed: String
     let results, page: Int
     let version: String
 }

 // MARK: - Result
 struct Result: Codable, Identifiable {
     var id: String { login.uuid } // ✅ Conforming to Identifiable
     let gender: Gender
     let name: Name
     let location: Location
     let email: String
     let login: Login
     let dob, registered: Dob
     let phone, cell: String
     let idInfo: ID // Renamed to avoid conflict
     let picture: Picture
     let nat: String
     var status: String? = nil // Add this for frontend use

     enum CodingKeys: String, CodingKey {
         case gender, name, location, email, login, dob, registered, phone, cell, picture, nat
         case idInfo = "id" // Renaming ID field to avoid conflict
     }
 }


 // MARK: - Dob
 struct Dob: Codable {
     let date: String
     let age: Int
 }

 enum Gender: String, Codable {
     case female = "female"
     case male = "male"
 }

 // MARK: - ID
 struct ID: Codable {
     let name: String
     let value: String?
 }

 // MARK: - Location
 struct Location: Codable {
     let street: Street
     let city, state, country: String
     let postcode: Postcode
     let coordinates: Coordinates
     let timezone: Timezone
 }

 // MARK: - Coordinates
 struct Coordinates: Codable {
     let latitude, longitude: String
 }

 enum Postcode: Codable {
     case integer(Int)
     case string(String)

     init(from decoder: Decoder) throws {
         let container = try decoder.singleValueContainer()
         if let x = try? container.decode(Int.self) {
             self = .integer(x)
             return
         }
         if let x = try? container.decode(String.self) {
             self = .string(x)
             return
         }
         throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
     }

     func encode(to encoder: Encoder) throws {
         var container = encoder.singleValueContainer()
         switch self {
         case .integer(let x):
             try container.encode(x)
         case .string(let x):
             try container.encode(x)
         }
     }
 }

 // MARK: - Street
 struct Street: Codable {
     let number: Int
     let name: String
 }

 // MARK: - Timezone
 struct Timezone: Codable {
     let offset, description: String
 }

 // MARK: - Login
 struct Login: Codable {
     let uuid, username, password, salt: String
     let md5, sha1, sha256: String
 }

 // MARK: - Name
 struct Name: Codable {
     let title, first, last: String
 }

 // MARK: - Picture
 struct Picture: Codable {
     let large, medium, thumbnail: String
 }

