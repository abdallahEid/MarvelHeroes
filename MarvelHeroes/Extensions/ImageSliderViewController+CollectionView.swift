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
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterSourceCell.reuseIdentifier, for: indexPath) as! CharacterSourceCell
        
        cell.sourceNameLabel.text = source[indexPath.row].title
        DispatchQueue.main.async {
            if let image = self.source[indexPath.row].thumbnail {
                cell.sourceImageView.sd_setImage(with: image.url)
            } else {
                cell.sourceImageView.image = UIImage(named: "notFound")
            }
        }
           
        return cell
    }
}

extension ImageSliderViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlideLabel.text = "\(indexPath.row)/\(source.count)"
    }
}
