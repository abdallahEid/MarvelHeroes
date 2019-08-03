//
//  CharacterDetailsViewController+CollectionView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension CharacterDetailsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicsCollectionView {
            return sources["comics"]!.count
        } else if collectionView == seriesCollectionView {
            return sources["series"]!.count
        } else if collectionView == storiesCollectionView {
            return sources["stories"]!.count
        } else if collectionView == eventsCollectionView {
            return sources["events"]!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterSourceCell.reuseIdentifier, for: indexPath) as! CharacterSourceCell
        
        if collectionView == comicsCollectionView {
            putDataInCell(source: "comics", cell: cell, indexPath: indexPath)
        } else if collectionView == seriesCollectionView {
            putDataInCell(source: "series", cell: cell, indexPath: indexPath)
        } else if collectionView == storiesCollectionView {
            putDataInCell(source: "stories", cell: cell, indexPath: indexPath)
        } else if collectionView == eventsCollectionView {
            putDataInCell(source: "events", cell: cell, indexPath: indexPath)
        }
        return cell
    }
    
    func putDataInCell(source: String, cell: CharacterSourceCell, indexPath: IndexPath){
        cell.sourceNameLabel.text = sources[source]![indexPath.row].title
        if let image = sources[source]![indexPath.row].thumbnail {
            cell.sourceImageView.sd_setImage(with: image.url)
        } else {
            cell.sourceImageView.image = UIImage(named: "notFound")
        }
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate{

}
