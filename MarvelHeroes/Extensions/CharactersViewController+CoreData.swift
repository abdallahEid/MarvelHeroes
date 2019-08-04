//
//  CharactersViewController+CoreData.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/4/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import CoreData

extension CharactersViewController {
    
    func addToCoreData(characters: [CharacterResponse]){
        
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
