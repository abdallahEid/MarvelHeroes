//
//  CharacterDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {
    
    // MARK: IBOutlets & Properties
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var bluredImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    var character: CharacterResponse?
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurBackground()
        configureCharacter()
        
        configureCollectionView(collectionView: comicsCollectionView)
        configureCollectionView(collectionView: seriesCollectionView)
        configureCollectionView(collectionView: eventsCollectionView)
        configureCollectionView(collectionView: storiesCollectionView)
        
        getCharacterSource(source: .comics, offset: 0)
        getCharacterSource(source: .series, offset: 0)
        getCharacterSource(source: .stories, offset: 0)
        getCharacterSource(source: .events, offset: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // remove navigtion from this view controller
        navigationController?.setNavigationBarHidden(true, animated: true)
        // change color of status bar
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.black
        view.addSubview(statusBarView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // return navigtion to the normal state
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: IBActions & Functions
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backbuttonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addBlurBackground(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 1)
    }
    
    func configureCharacter(){
        characterNameLabel.text = character?.name
        characterDescriptionLabel.text = character?.description
        if let thumbnail = character?.thumbnail {
            characterImageView.sd_setImage(with: thumbnail.url)
            bluredImageView.sd_setImage(with: thumbnail.url)
        } else { // From Local Storage 
            if let imageData = character?.imageData{
                characterImageView.image = UIImage(data: imageData)
                bluredImageView.image = UIImage(data: imageData)
            }
        }
        bluredImageView.alpha = 0.2
    }
    
    func configureCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterSourceCell.nib, forCellWithReuseIdentifier: CharacterSourceCell.reuseIdentifier)
    }
    
    func getCharacterSource(source: CharacterSourceType, offset: Int){
        if var urlString = character?.resourceURI {

            urlString += "/\(source)\(MarvelClient.Endpoints.apiKeyParam)&limit=10&offset=\(offset)"
            if let url = URL(string: urlString){
                CharactersAPIs().getCharacterSource(url: url) { (charactersSource, error) in
                    guard let charactersSource = charactersSource else {
                        return
                    }
                    switch source {
                    case .comics:
                        self.comicsCollectionView.sourceArray.append(contentsOf: charactersSource)
                        self.comicsCollectionView.selectedSource = source
                        self.comicsCollectionView.reloadData()
                    case .series:
                        self.seriesCollectionView.sourceArray.append(contentsOf: charactersSource)
                        self.seriesCollectionView.selectedSource = source
                        self.seriesCollectionView.reloadData()
                    case .stories:
                        self.storiesCollectionView.sourceArray.append(contentsOf: charactersSource)
                        self.storiesCollectionView.selectedSource = source
                        self.storiesCollectionView.reloadData()
                    case .events:
                        self.eventsCollectionView.sourceArray.append(contentsOf: charactersSource)
                        self.eventsCollectionView.selectedSource = source
                        self.eventsCollectionView.reloadData()
                    }
                }
            }
        }
    }
}
