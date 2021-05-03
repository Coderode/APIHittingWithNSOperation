// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collectionResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: jsonData)

import Foundation

// MARK: - CollectionResponse
struct CollectionResponse: Codable {
    let paging: Paging?
    let items: [Item]?
    let sortedBy: SortedBy?
    let collectionID: Int?
    let collectionName, title, collectionResponseDescription: String?
    let createdAt, modifiedAt: String?
    let filteredBy: FilteredBy?

    enum CodingKeys: String, CodingKey {
        case paging, items, sortedBy
        case collectionID = "collectionId"
        case collectionName, title
        case collectionResponseDescription = "description"
        case createdAt, modifiedAt, filteredBy
    }
}

// MARK: - FilteredBy
struct FilteredBy: Codable {
    let audio, noprogress: Bool?
    let rating: Int?
}

// MARK: - Item
struct Item: Codable {
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

// MARK: - Paging
struct Paging: Codable {
    let page, psize, count, countTotal: Int
}

// MARK: - SortedBy
struct SortedBy: Codable {
    let sort, order: String
}
