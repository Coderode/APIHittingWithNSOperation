//
//  HomeScreenUIVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import UIKit

class HomeScreenUIVC: NSObject {
    var view : HomeScreenView! {
        didSet{
            setUI()
        }
    }
    var homeRailData = [Int : Any]()
    func setUI(){
        settableview()
    }
    func settableview(){
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.tableView.register(UINib(nibName: "PromoTVC", bundle: .main), forCellReuseIdentifier: "PromoTVC")
        view.tableView.register(UINib(nibName: "SummaryCollectionTVC", bundle: .main), forCellReuseIdentifier: "SummaryCollectionTVC")
        view.tableView.rowHeight = UITableView.automaticDimension
        view.tableView.estimatedRowHeight = UITableView.automaticDimension
        view.tableView.separatorStyle = .none
        view.tableView.tableFooterView = UIView()
        view.tableView.allowsSelection = false
        view.tableView.showsVerticalScrollIndicator = false
        view.tableView.showsHorizontalScrollIndicator = false
        view.tableView.tintColor = .white
    }
    
    func startFetchingRailData() {
        if let visibleIndexPaths = self.view?.tableView.indexPathsForVisibleRows {
            for visibleIndex in visibleIndexPaths {
                fetchRailItems(visibleIndex: visibleIndex)
            }
        }
    }
    
    func fetchRailItems(visibleIndex : IndexPath){
        
        let railItem = self.view.homeRails.rails[visibleIndex.row]
        switch  railItem.railType {
        
        case .PROMOTION:
            DispatchQueue.main.async {
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as? PromoTVC {
                    HomeRestManger.shared.getPromotionData(promoName: railItem.promoName ?? "") { (response) in
                        switch response {
                        case .success(let response):
                            let promo = Promo(imageUrl: response.coverURI)
                            let data = PromoTableViewCell(promos: [promo])
                            self.homeRailData[visibleIndex.row] = data
                            cell.updateAppearance(content: data)
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        case .COLLECTION:
            DispatchQueue.main.async {
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as? SummaryCollectionTVC {
                    HomeRestManger.shared.getCollectiondata(page: 0, pageSize: 10, collectionName: railItem.collectionName ?? "") { (response) in
                        switch response {
                        case .success(let response):
                            var bookSummaries = [BookSummary]()
                            for item in response.items {
                                bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: Float(item.rating)))
                            }
                            let summary = SummaryCollectionTableViewCell(collectionTitle: response.title, bookSummaries: bookSummaries)
                            self.homeRailData[visibleIndex.row] = summary
                            cell.updateAppearance(content: summary)
                        case .failure(_):
                            break
                        }
                    }
                }
                
            }
        case .INPROGRESS:
            DispatchQueue.main.async {
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as? SummaryCollectionTVC {
                    HomeRestManger.shared.getInprogressData(page: 0, pageSize: 10) { (response) in
                        switch response {
                        case .success(let response):
                            var bookSummaries = [BookSummary]()
                            for item in response.items {
                                bookSummaries.append(BookSummary(imageUrl: item.summary.coverURI, title: item.summary.title, rating: Float(item.summary.rating)))
                            }
                            let summary = SummaryCollectionTableViewCell(collectionTitle: "Continue Reading", bookSummaries: bookSummaries)
                            self.homeRailData[visibleIndex.row] = summary
                            cell.updateAppearance(content: summary)
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        case .RECOMMENDATION:
            DispatchQueue.main.async {
                if let cell = self.view.tableView.cellForRow(at: visibleIndex) as? SummaryCollectionTVC {
                    HomeRestManger.shared.getRecommendationsData(page: 0, pageSize: 10) { (response) in
                        switch response {
                        case .success(let response):
                            var bookSummaries = [BookSummary]()
                            for item in response.items {
                                bookSummaries.append(BookSummary(imageUrl: item.coverURI, title: item.title, rating: Float(item.rating)))
                            }
                            let summary = SummaryCollectionTableViewCell(collectionTitle: response.title, bookSummaries: bookSummaries)
                            self.homeRailData[visibleIndex.row] = summary
                            cell.updateAppearance(content: summary)
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
    }
}

extension HomeScreenUIVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.homeRails.rails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if view.homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoTVC", for: indexPath) as?  PromoTVC else {
                return UITableViewCell()
            }
            if let celldata = self.homeRailData[indexPath.row] as? PromoTableViewCell{
                cell.updateAppearance(content: celldata)
            }else{
                cell.updateAppearance(content: .none)
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCollectionTVC", for: indexPath) as?  SummaryCollectionTVC else {
                return UITableViewCell()
            }
            if let celldata = self.homeRailData[indexPath.row] as? SummaryCollectionTableViewCell  {
                cell.updateAppearance(content: celldata)
            }else{
                cell.updateAppearance(content: .none)
            }
            return cell
        }
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if view.homeRails.rails[indexPath.row].railType == RailType.PROMOTION {
            return 200
        }else{
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                guard self.homeRailData[indexPath.row] == nil else { return }
                self.startFetchingRailData()
            }
        }
    }
   
}


