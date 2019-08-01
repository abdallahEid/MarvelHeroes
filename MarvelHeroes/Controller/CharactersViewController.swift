//
//  CharactersViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

/* NOTE: There is an extension to handle table view protocols (delegates and data sources) in path: /Extensions/CharactersViewController+TableView
 */

import UIKit

class CharactersViewController: UIViewController {

    // MARK: IBOutlets & Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavbarLogo()
        configureTable()
    }
    
    // MARK: IBAction & Functions
    
    func configureNavbarLogo(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "icn-nav-marvel")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CharacterCell.nib, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
    }
}
