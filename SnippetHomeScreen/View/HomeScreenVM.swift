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
                self.view.homeDataSource = DataStore(homeRails: response)
                self.view.tableView.reloadData()
            case .failure(let error):
                print("home rail : " + error.localizedDescription)
            }
        }
    }
}
