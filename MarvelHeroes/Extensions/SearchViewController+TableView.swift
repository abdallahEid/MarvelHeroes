//
//  SearchViewController+TableView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier ) as! SearchCell
        
        cell.characterLabelName.text = characters[indexPath.row].name
        cell.characterImageView.sd_setImage(with: characters[indexPath.row].thumbnail?.url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterDetailsController = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        
        characterDetailsController.character = characters[indexPath.row]
        navigationController?.pushViewController(characterDetailsController, animated: true)
    }
}
