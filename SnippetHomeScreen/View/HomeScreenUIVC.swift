//
//  HomeScreenUIVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import UIKit

class HomeScreenUIVC: NSObject {
    var view : HomeScreenView!
    
    func setUI(){
        settableview()
    }
    var loadingOperations: [IndexPath: AsyncOperation] = [:]
    var homeData = [Int : Any]()
    
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
    
    func fetchIndexData(visibleIndex : IndexPath){
        if let data = self.homeData[visibleIndex.row] {
            DispatchQueue.main.async {
                let cell = self.view.tableView.cellForRow(at: visibleIndex)
                if self.view.homeRails?.rails[visibleIndex.row].railType == RailType.PROMOTION {
                    if let cell = cell as? PromoTVC {
                        cell.updateAppearance(content: data as? PromoTableViewCell)
                        return
                    }
                }else{
                    if let cell = cell as? SummaryCollectionTVC {
                        cell.updateAppearance(content: data as? SummaryCollectionTableViewCell)
                        return
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                guard let cell = self.view.tableView.cellForRow(at: visibleIndex) else { return }
                // How should the operation update the cell once the data has been loaded?
                self.view.homeDataSource?.loadData(at: visibleIndex, completion: { [weak self] (data) in
                    guard let self = self else {
                        return
                    }
                    if self.view.homeRails?.rails[visibleIndex.row].railType == RailType.PROMOTION {
                        if let cell = cell as? PromoTVC {
                            cell.updateAppearance(content: data as? PromoTableViewCell)
                        }
                    }else{
                        if let cell = cell as? SummaryCollectionTVC {
                            cell.updateAppearance(content: data as? SummaryCollectionTableViewCell)
                        }
                    }
                    self.homeData[visibleIndex.row] = data
                    self.loadingOperations.removeValue(forKey: visibleIndex)
                }, apiCaller: { (apicaller) in
                    self.loadingOperations[visibleIndex] = apicaller as? AsyncOperation
                })
            }
        }
    }
}

extension HomeScreenUIVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return view.homeRails?.rails.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if view.homeRails?.rails[indexPath.row].railType == RailType.PROMOTION {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoTVC", for: indexPath) as?  PromoTVC else {
                return UITableViewCell()
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCollectionTVC", for: indexPath) as?  SummaryCollectionTVC else {
                return UITableViewCell()
            }
            return cell
        }
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if view.homeRails?.rails[indexPath.row].railType == RailType.PROMOTION {
            return 200
        }else{
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.fetchIndexData(visibleIndex: indexPath)
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataLoader = loadingOperations[indexPath] {
            dataLoader.cancel()
            loadingOperations.removeValue(forKey: indexPath)
        }
    }
   
}


