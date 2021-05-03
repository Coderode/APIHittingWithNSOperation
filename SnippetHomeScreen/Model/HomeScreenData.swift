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

    public func loadData(at visibleIndex: IndexPath) -> DataLoadOperation? {
        let railItem = self.homeRails?.rails[visibleIndex.row]
        return DataLoadOperation(railItem!)
    }
}


class DataLoadOperation: Operation {
    var cellData : Any?
    var loadingCompleteHandler: ((Any) ->Void)?
    
    private let _railItem: Rail
    
    init(_ railItem: Rail) {
        _railItem = railItem
    }
    override func main() {
        if isCancelled { return }
        //api call
        self.loadData { (data) in
            self.cellData = data
            if self.isCancelled { return }
            if let loadingCompleteHandler = self.loadingCompleteHandler {
                DispatchQueue.main.async {
                    loadingCompleteHandler(self.cellData as Any)
                }
            }
        }
    }
    
    func loadData(completion : ((Any) -> Void)?){
        switch  self._railItem.railType {
        case .PROMOTION:
            HomeRestManger.shared.getPromotionData(promoName: self._railItem.promoName ?? "") { (response) in
                switch response {
                case .success(let response):
                    let promo = Promo(imageUrl: response.coverURI!)
                    let data = PromoTableViewCell(promos: [promo])
                    completion?(data)
                case .failure(let error):
                    print("promo" + error.localizedDescription)
                }
            }
        case .COLLECTION:
            HomeRestManger.shared.getCollectiondata(page: 0, pageSize: 20, collectionName: self._railItem.collectionName ?? "") { (response) in
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
            }
        case .INPROGRESS:
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
            }
        case .RECOMMENDATION:
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
            }
        }
    }
}






