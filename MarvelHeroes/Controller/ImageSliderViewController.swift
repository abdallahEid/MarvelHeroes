//
//  ImageSliderViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

/* NOTE: There is an extension to handle collection view protocols (delegates and data sources) in path: /Extensions/ImageSliderViewController.swift+CollectionView
 */
import UIKit

class ImageSliderViewController: UIViewController {

    // MARK: IBOutlets & Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentSlideLabel: UILabel!
    
    var source = [CharacterSourceResponse]()
    var indexPath: IndexPath!
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // This to get the selected item in collection view ( commic, series, ... ) and open the collection view on it 
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: IBAction & Functions
    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterSourceCell.nib, forCellWithReuseIdentifier: CharacterSourceCell.reuseIdentifier)
    }
}
