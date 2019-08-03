//
//  CharactersViewController+TableView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier ) as! CharacterCell
        
        cell.characterName.text = characters[indexPath.row].name
        if let thumbnail = characters[indexPath.row].thumbnail {
            cell.characterImageView.sd_setImage(with: thumbnail.url)
        } else {
            cell.characterImageView.image = UIImage(data: characters[indexPath.row].imageData!)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.28
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsController = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        
        characterDetailsController.character = characters[indexPath.row]
        navigationController?.pushViewController(characterDetailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastCharacter = characters.count - 1
        
        if indexPath.row == lastCharacter && lastCharacter > 15 && (AppDelegate.isConnectedToInternet ?? true) {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.startAnimating()
            activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))

            tableView.tableFooterView = activityIndicator
            tableView.tableFooterView?.isHidden = false
            
            getCharacters(offset: characters.count)
        }
    }
}
