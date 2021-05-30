//
//  HomeScreenData.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation

protocol APIService {
    func loadData(at visibleIndex: IndexPath,railItem : Rail,  completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?)
}


class APIServieProvider : APIService {
    func loadData(at visibleIndex: IndexPath, railItem: Rail, completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?) {
        switch railItem.railType {
        case .PROMOTION:
            PromotionAPIService().loadData(at: visibleIndex, railItem: railItem, completion: completion, apiCaller: apiCaller)
        case .COLLECTION:
            CollectionAPIService().loadData(at: visibleIndex, railItem: railItem, completion: completion, apiCaller: apiCaller)
        case .INPROGRESS:
            InprogressAPIService().loadData(at: visibleIndex, railItem: railItem, completion: completion, apiCaller: apiCaller)
        case .RECOMMENDATION:
            RecommendationAPIService().loadData(at: visibleIndex, railItem: railItem, completion: completion, apiCaller: apiCaller)
        }
    }
}


struct PromotionAPIService : APIService {
    func loadData(at visibleIndex: IndexPath,railItem : Rail, completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?) {
        HomeRestManger.shared.getPromotionData(promoName: railItem.promoName ?? "") { (response) in
            switch response {
            case .success(let response):
                let promo = Promo(imageUrl: response.coverURI!)
                let data = PromoTableViewCell(promos: [promo])
                completion?(data)
            case .failure(let error):
                print("promo" + error.localizedDescription)
            }
        } getAPICaller: { (apicaller) in
            apiCaller?(apicaller)
        }
    }
}

struct CollectionAPIService : APIService {
    func loadData(at visibleIndex: IndexPath, railItem: Rail, completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?) {
        HomeRestManger.shared.getCollectiondata(page: 0, pageSize: 20, collectionName: railItem.collectionName ?? "") { (response) in
            switch response {
            case .success(let response):
                var bookSummaries = [BookSummary]()
                for item in response.items! {
                    bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: (item.rating)))
                }
                let summary = SummaryCollectionTableViewCell(collectionTitle: response.title!, bookSummaries: bookSummaries)
                completion?(summary)
            case .failure(let error):
                print("collection" + error.localizedDescription)
            }
        } getAPICaller: { (apicaller) in
            apiCaller?(apicaller)
        }
    }
}

struct InprogressAPIService : APIService {
    func loadData(at visibleIndex: IndexPath, railItem: Rail, completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?) {
        HomeRestManger.shared.getInprogressData(page: 0, pageSize: 20) { (response) in
            switch response {
            case .success(let response):
                var bookSummaries = [BookSummary]()
                for item in response.items! {
                    bookSummaries.append(BookSummary(imageUrl: item.summary.coverURI, title: item.summary.title, rating: (item.summary.rating)))
                }
                let summary = SummaryCollectionTableViewCell(collectionTitle: "Continue Reading", bookSummaries: bookSummaries)
                completion?(summary)
                //cell.updateAppearance(content: summary)
            case .failure(let error):
                print("inprogress" + error.localizedDescription)
            }
        } getAPICaller: { (apicaller) in
            apiCaller?(apicaller)
        }
    }
}

struct RecommendationAPIService : APIService {
    func loadData(at visibleIndex: IndexPath, railItem: Rail, completion: ((Any) -> Void)?, apiCaller: ((Any) -> Void)?) {
        HomeRestManger.shared.getRecommendationsData(page: 0, pageSize: 20) { (response) in
            switch response {
            case .success(let response):
                var bookSummaries = [BookSummary]()
                for item in response.items! {
                    bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: (item.rating)))
                }
                let summary = SummaryCollectionTableViewCell(collectionTitle: response.title!, bookSummaries: bookSummaries)
                completion?(summary)
            case .failure(let error):
                print("recommendation" + error.localizedDescription)
            }
        } getAPICaller: { (apicaller) in
            apiCaller?(apicaller)
        }
    }
}

