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
        return collectionView.sourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterSourceCell.reuseIdentifier, for: indexPath) as! CharacterSourceCell
        cell.sourceNameLabel.text = collectionView.sourceArray[indexPath.row].title
        cell.sourceImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        DispatchQueue.main.async {
            if let image = collectionView.sourceArray[indexPath.row].thumbnail {
                cell.sourceImageView.sd_setImage(with: image.url)
            } else {
                cell.sourceImageView.image = UIImage(named: "notFound")
            }
        }
        return cell
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageSliderViewController = storyboard?.instantiateViewController(withIdentifier: "ImageSliderViewController") as! ImageSliderViewController
        
        imageSliderViewController.source = collectionView.sourceArray
        imageSliderViewController.indexPath = indexPath
        
        present(imageSliderViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSource = collectionView.sourceArray.count - 1

        if indexPath.row == lastSource && lastSource > 5 {
            getCharacterSource(source: collectionView.selectedSource, offset: lastSource + 1)
        }
    }
}
