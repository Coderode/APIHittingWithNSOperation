//
//  ViewController.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

protocol HomeScreenView {
    var tableView: UITableView! { get }
    var homeRails : RailStructure { get set }
    var homeDataSource : DataStore? { get set }
}

class HomeScreenVC : UIViewController,HomeScreenView {
    @IBOutlet weak var tableView: UITableView!
    var homeRails : RailStructure = RailStructure(rails: [Rail]())
    var homeDataSource : DataStore?
    private var uiVC : HomeScreenUIVC!
    private var vm : HomeScreenVM!
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


