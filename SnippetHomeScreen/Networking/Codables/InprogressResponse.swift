//
//  InprogressResponse.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let inprogressResponse = try? newJSONDecoder().decode(InprogressResponse.self, from: jsonData)

import Foundation

// MARK: - InprogressResponse
struct InprogressResponse: Codable {
    let paging: Paging
    let items: [InprogressItem]
    let sortedBy: SortedBy
    let filteredBy: FilteredBy
}

// MARK: - Item
struct InprogressItem: Codable {
    let readingProgress, lastReadAt: Int
    let summary: Summary
}

// MARK: - Summary
struct Summary: Codable {
    let summaryID: Int
    let title, publicationInfo: String
    let rating: Double
    let coverURI: String
    let audio: Bool

    enum CodingKeys: String, CodingKey {
        case summaryID = "summaryId"
        case title, publicationInfo, rating
        case coverURI = "coverUri"
        case audio
    }
}
