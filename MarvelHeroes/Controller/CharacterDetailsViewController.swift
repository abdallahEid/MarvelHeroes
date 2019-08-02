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
    
    var character: CharacterResponse?
    
    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBlurBackground()
        configureCharacter()
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
        characterImageView.sd_setImage(with: character?.thumbnail.url)
        bluredImageView.sd_setImage(with: character?.thumbnail.url)
        bluredImageView.alpha = 0.2
    }

}
