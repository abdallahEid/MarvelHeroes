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
import CoreData
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
        
        if Reachability()!.isReachable {
            deleteFromCoreData()
            getCharacters(offset: 0)
        } else {
            loadFromCoreData()
        }
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
    
    func addToCoreData(characters: [CharacterResponse]){
        print("LAA")

        for item in characters {
            let character = CharacterData(context: dataController.viewContext)
            character.name = item.name
            if let thumbnail = item.thumbnail {
                character.url = thumbnail.path
                ImageAPIs().downloadImageFrom(url: thumbnail.url) { (data, error) in
                    if let data = data {
                        character.image = data
                        try? self.dataController.viewContext.save()
                    }
                }
            }
        }
    }
    
    func deleteFromCoreData() {
        print("LA")
        let fetchRequest:NSFetchRequest<CharacterData> = CharacterData.fetchRequest()
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            for result in results {
                dataController.viewContext.delete(result)
            }
            try? self.dataController.viewContext.save()
        }
    }
    
    func loadFromCoreData() {
        let fetchRequest:NSFetchRequest<CharacterData> = CharacterData.fetchRequest()
        if let results = try? dataController.viewContext.fetch(fetchRequest) {
            for result in results {
                let character = CharacterResponse(name: result.name ?? "", imageData: result.image ?? Data())
                characters.append(character)
            }
            tableView.reloadData()
        }
    }
}
