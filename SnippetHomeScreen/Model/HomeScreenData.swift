//
//  HomeScreenData.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation
class DataStore {
    private var homeRails : RailStructure?
    init(homeRails : RailStructure){
        self.homeRails = homeRails
    }

    public var numberOfCells: Int {
        return homeRails?.rails.count ?? 0
    }

    public func loadData(at index: Int,completion:( (Any)->())?) {
        if (0..<(homeRails?.rails.count)!).contains(index) {
            if homeRails?.rails[index].railType == RailType.PROMOTION{
                HomeRestManger.shared.getPromotionData(promoName: (homeRails?.rails[index].promoName)!) { (response) in
                    switch response {
                    case .success(let response):
                        let promo = Promo(imageUrl: response.coverURI)
                        let data = PromoTableViewCell(promos: [promo])
                        completion?(data)
                    case .failure(_):
                        break
                    }
                }
            }else if homeRails?.rails[index].railType == RailType.COLLECTION {
                HomeRestManger.shared.getCollectiondata(page: 0, pageSize: 10, collectionName: (homeRails?.rails[index].collectionName)!) { (response) in
                    switch response {
                    
                    case .success(let response):
                        var bookSummaries = [BookSummary]()
                        for item in response.items {
                            bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: Float(item.rating)))
                        }
                        let summary = SummaryCollectionTableViewCell(collectionTitle: response.title, bookSummaries: bookSummaries)
                        completion?(summary)
                    case .failure(_):
                        break
                    }
                }
            }else if  homeRails?.rails[index].railType == RailType.INPROGRESS{
                HomeRestManger.shared.getInprogressData(page: 0, pageSize: 10) { (response) in
                    switch response {
                    case .success(let response):
                        var bookSummaries = [BookSummary]()
                        for item in response.items {
                            bookSummaries.append(BookSummary(imageUrl: item.summary.coverURI, title: item.summary.title, rating: Float(item.summary.rating)))
                        }
                        let summary = SummaryCollectionTableViewCell(collectionTitle: "Continue Reading", bookSummaries: bookSummaries)
                        completion?(summary)
                    case .failure(_):
                        break
                    }
                }
            }else if homeRails?.rails[index].railType == RailType.RECOMMENDATION {
                HomeRestManger.shared.getRecommendationsData(page: 0, pageSize: 10) { (response) in
                    switch response {
                    case .success(let response):
                        var bookSummaries = [BookSummary]()
                        for item in response.items {
                            bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: Float(item.rating)))
                        }
                        let summary = SummaryCollectionTableViewCell(collectionTitle: response.title, bookSummaries: bookSummaries)
                        completion?(summary)
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}


class DataLoadOperation: Operation {
    var cellData : Any?
    var loadingCompleteHandler: ((Any) ->Void)?
    
    private let _cellData: Any
    
    init(_ cellData: Any) {
        _cellData = cellData
    }
    
    override func main() {
        if isCancelled { return }
        cellData = _cellData
        if let loadingCompleteHandler = loadingCompleteHandler {
            DispatchQueue.main.async {
                loadingCompleteHandler(self._cellData)
            }
        }
    }
}


