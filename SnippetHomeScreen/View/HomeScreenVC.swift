//
//  ViewController.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

protocol HomeScreenView {
    var tableView: UITableView! { get }
    var homeRails : RailStructure? { get set }
    var service : APIServieProvider? { get set }
}

class HomeScreenVC : UIViewController,HomeScreenView {
    @IBOutlet weak var tableView: UITableView!
    var homeRails : RailStructure? = RailStructure(rails: [Rail(railID: 1, railType: .PROMOTION, promoName: "", collectionName: ""), Rail(railID: 2, railType: .COLLECTION, promoName: "", collectionName: ""),Rail(railID: 3, railType: .COLLECTION, promoName: "", collectionName: "")])
    private var uiVC : HomeScreenUIVC!
    private var vm : HomeScreenVM!
    var service: APIServieProvider?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiVC = HomeScreenUIVC()
        uiVC.view = self
        uiVC.setUI()
        self.vm = HomeScreenVM()
        vm.view = self
        vm.loadHomeScreenRails()
    }
}


