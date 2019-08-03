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
    var currentSource = ""
    var sources = ["comics" : [CharacterSourceResponse](), "series" : [CharacterSourceResponse](), "stories" : [CharacterSourceResponse](), "events" : [CharacterSourceResponse]()]
    
    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurBackground()
        configureCharacter()
        configureCollectionView(collectionView: comicsCollectionView)
        configureCollectionView(collectionView: seriesCollectionView)
        configureCollectionView(collectionView: eventsCollectionView)
        configureCollectionView(collectionView: storiesCollectionView)
        getCharacterSources()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.black
        view.addSubview(statusBarView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: IBActions & Functions

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backbuttonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCharacterSources(){
        for (key, _) in sources {
            getCharacterSource(source: key)
        }
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
        characterImageView.sd_setImage(with: character?.thumbnail?.url)
        bluredImageView.sd_setImage(with: character?.thumbnail?.url)
        bluredImageView.alpha = 0.2
    }
    
    func configureCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterSourceCell.nib, forCellWithReuseIdentifier: CharacterSourceCell.reuseIdentifier)
    }
    
    
    func getCharacterSource(source: String){
        if var urlString = character?.resourceURI {

            urlString += "/\(source)" + MarvelClient.Endpoints.apiKeyParam
            if let url = URL(string: urlString){

                CharactersAPIs().getCharacterSource(url: url) { (charactersSource, error) in
                    guard let charactersSource = charactersSource else {
                        return
                    }
                    self.sources[source] = charactersSource
                    self.currentSource = source
                    if source == "comics"{
                        self.comicsCollectionView.reloadData()
                    } else if source == "series"{
                        self.seriesCollectionView.reloadData()
                    } else if source == "stories"{
                        self.storiesCollectionView.reloadData()
                    } else if source == "events"{
                        self.eventsCollectionView.reloadData()
                    }
                }
            }
        }
       
    }
}
