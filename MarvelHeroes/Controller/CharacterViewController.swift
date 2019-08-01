//
//  CharacterViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/1/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {

    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavbarLogo()
    }
    
    // MARK: IBAction & Functions
    
    func configureNavbarLogo(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "icn-nav-marvel")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
}
