//
//  SearchViewController+SearchBar.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchedCharacters(searchText: searchText)
    }
    
    func getSearchedCharacters(searchText: String){
        CharactersAPIs().getCharacters(limit: 20, offset: 0, nameStartsWith: searchText,completion: getSearchedCharactersCompletion(characters:error:))
    }
    
    func getSearchedCharactersCompletion(characters: [CharacterResponse]?, error: Error?){
        guard let characters = characters else {
            return
        }
        self.characters = characters
        tableView.reloadData()
    }
    
}
