//
//  SearchViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

/* NOTE: There is an extension to handle table view protocols (delegates and data sources) in path: /Extensions/SearchViewController+TableView
 
    And Also an extension to handle Search Bar delegate in path: /Extensions/SearchViewController+SearchBar
 */

import UIKit

class SearchViewController: UIViewController {

    // MARK: IBOutlets & Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var characters = [CharacterResponse]()
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTable()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // remove navigtion from this view controller
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // return navigtion to the normal state 
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: IBActions & Functions
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(SearchCell.nib, forCellReuseIdentifier: SearchCell.reuseIdentifier)
    }
    
    private func configureSearchBar(){
        searchBar.delegate = self
    }
    
}
