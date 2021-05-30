//
//  HomeScreenVM.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import UIKit

class HomeScreenVM: NSObject {
    var view : HomeScreenView!
    
    
    func loadHomeScreenRails(){
        //api call for structure
        HomeRestManger.shared.getRailStructure { (response) in
            switch response {
            case .success(let response):
                self.view.homeRails = response
                self.view.service = APIServieProvider()
                self.view.tableView.reloadData()
            case .failure(_):
                //show default dummy data
                self.view.homeRails = RailStructure(rails: [Rail(railID: 1, railType: .PROMOTION, promoName: "", collectionName: ""), Rail(railID: 2, railType: .COLLECTION, promoName: "", collectionName: ""),Rail(railID: 3, railType: .COLLECTION, promoName: "", collectionName: "")])
                //print("home rail : " + error.localizedDescription)
            }
        }
    }
}
