//
//  Repository.swift
//  GitHub_Project
//
//  Created by KhaleD HuSsien on 24/03/2022.
//

import Foundation
struct Repository: Codable {
    let repName: String?
    let owner: Owner?
    enum CodingKeys: String,CodingKey{
        case repName = "name"
        case owner
    }
}
struct Owner: Codable{
    let ownerImage: String?
    enum CodingKeys: String,CodingKey{
        case ownerImage = "avatar_url"
    }
}
