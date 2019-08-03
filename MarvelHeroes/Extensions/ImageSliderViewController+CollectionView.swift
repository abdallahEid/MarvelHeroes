//
//  ImageSliderViewController+CollectionView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension ImageSliderViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources[selectedSource]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterSourceCell.reuseIdentifier, for: indexPath) as! CharacterSourceCell
        
        cell.sourceNameLabel.text = sources[selectedSource]![indexPath.row].title
        if let image = sources[selectedSource]![indexPath.row].thumbnail {
            cell.sourceImageView.sd_setImage(with: image.url)
        } else {
            cell.sourceImageView.image = UIImage(named: "notFound")
        }
       
        return cell
    }
}

extension ImageSliderViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlideLabel.text = "\(indexPath.row)/\(sources[selectedSource]!.count)"
    }
}
