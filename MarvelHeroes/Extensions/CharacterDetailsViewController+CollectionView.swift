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
        cell.sourceImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        
        if let image = sources[source]![indexPath.row].thumbnail {
            cell.sourceImageView.sd_setImage(with: image.url)
        } else {
            cell.sourceImageView.image = UIImage(named: "notFound")
        }
    }
}

extension CharacterDetailsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageSliderViewController = storyboard?.instantiateViewController(withIdentifier: "ImageSliderViewController") as! ImageSliderViewController
        
        if collectionView == comicsCollectionView {
            imageSliderViewController.selectedSource = "comics"
        } else if collectionView == seriesCollectionView {
            imageSliderViewController.selectedSource = "series"
        } else if collectionView == storiesCollectionView {
            imageSliderViewController.selectedSource = "stories"
        } else if collectionView == eventsCollectionView {
            imageSliderViewController.selectedSource = "events"
        }
        imageSliderViewController.sources = sources
        imageSliderViewController.indexPath = indexPath

        present(imageSliderViewController, animated: true) 
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        var lastSource = 0
        
        if collectionView == comicsCollectionView {
            lastSource = sources["comics"]!.count
        } else if collectionView == seriesCollectionView {
            lastSource = sources["series"]!.count
        } else if collectionView == storiesCollectionView {
            lastSource = sources["stories"]!.count
        } else if collectionView == eventsCollectionView {
            lastSource = sources["events"]!.count
        }
        print(lastSource, "last", indexPath.row)

        if indexPath.row == lastSource - 1 && lastSource > 5 {
            print(lastSource, "last")

            if collectionView == comicsCollectionView {
                getCharacterSource(source: "comics", offset: lastSource)
            } else if collectionView == seriesCollectionView {
                getCharacterSource(source: "series", offset: lastSource)
            } else if collectionView == storiesCollectionView {
                getCharacterSource(source: "stories", offset: lastSource)
            } else if collectionView == eventsCollectionView {
                getCharacterSource(source: "events", offset: lastSource)
            }
        }
    }
}
