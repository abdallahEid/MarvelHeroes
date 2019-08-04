//
//  CharactersViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

/* NOTE: There is an extension to handle table view protocols (delegates and data sources) in path: /Extensions/CharactersViewController+TableView
 
    And Also an extension to handle Core Data and local storage in path: /Extensions/CharactersViewController+CoreData
 */

import UIKit
import SDWebImage

class CharactersViewController: UIViewController {

    // MARK: IBOutlets & Properties
    @IBOutlet weak var tableView: UITableView!
    
    var dataController = DataController(modelName: "MarvelHeroes")
    var characters = [CharacterResponse]()
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbarLogo()
        configureTable()
        DetermineGettingDataFromInternetOrCoreData()
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
    
    // Network Stuff 
    func getCharacters(offset: Int){
        if offset == 0 {
            self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        }
        CharactersAPIs().getCharacters(limit: 20, offset: offset, completion: getCharactersCompletion(characters:error:))
    }
    
    func getCharactersCompletion(characters: [CharacterResponse]?, error: Error?){
        self.view.activityStopAnimating()
        guard let characters = characters else {
            return
        }
        self.characters += characters
        if self.characters.count == 20 {
            addToCoreData(characters: characters)
        }
        tableView.reloadData()
    }
    
    func DetermineGettingDataFromInternetOrCoreData(){
        if Reachability()!.isReachable {
            deleteFromCoreData()
            getCharacters(offset: 0)
        } else {
            loadFromCoreData()
        }
    }
}
