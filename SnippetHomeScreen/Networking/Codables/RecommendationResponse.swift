//
//  Recommendation.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation

// MARK: - RecommendationResponse
struct RecommendationResponse: Codable {
    let paging: Paging
    let items: [Item]
    let sortedBy: SortedBy
    let title, recommendationResponseDescription: String
    let filteredBy: FilteredBy

    enum CodingKeys: String, CodingKey {
        case paging, items, sortedBy, title
        case recommendationResponseDescription = "description"
        case filteredBy
    }
}
