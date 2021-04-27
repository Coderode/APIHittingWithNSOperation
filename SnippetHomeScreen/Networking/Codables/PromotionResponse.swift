// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let promotionResponse = try? newJSONDecoder().decode(PromotionResponse.self, from: jsonData)

import Foundation

// MARK: - PromotionResponse
struct PromotionResponse: Codable {
    let promoName, promoType, title: String
    let coverURI: String
    let summary: Summary

    enum CodingKeys: String, CodingKey {
        case promoName, promoType, title
        case coverURI = "coverUri"
        case summary
    }
}
