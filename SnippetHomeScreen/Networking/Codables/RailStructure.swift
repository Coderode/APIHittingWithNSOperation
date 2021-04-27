//
//  RailStructure.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation


// MARK: - RecommendationResponse
struct RailStructure: Codable {
    let rails: [Rail]
}

// MARK: - Rail
struct Rail: Codable {
    let railID: Int
    let railType: RailType
    let promoName, collectionName: String?

    enum CodingKeys: String, CodingKey {
        case railID = "railId"
        case railType, promoName, collectionName
    }
}


enum RailType: String, Codable {
    case PROMOTION = "PROMOTION"
    case COLLECTION = "COLLECTION"
    case INPROGRESS = "INPROGRESS"
    case RECOMMENDATION = "RECOMMENDATION"
}
