//
//  CharactersViewController+TableView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier ) as! CharacterCell
        
        cell.characterName.text = characters[indexPath.row].name
        
        ImageAPIs().downloadImageFrom(url: characters[indexPath.row].thumbnail.url) { (image, error) in
            if let image = image {
                cell.characterImageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsController = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        
        navigationController?.pushViewController(characterDetailsController, animated: true)
    }
}
