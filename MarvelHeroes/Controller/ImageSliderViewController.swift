//
//  ImageSliderViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var currentSlideLabel: UILabel!
    var selectedSource:String!
    var sources = [String: [CharacterSourceResponse]]()
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterSourceCell.nib, forCellWithReuseIdentifier: CharacterSourceCell.reuseIdentifier)
    }
}
