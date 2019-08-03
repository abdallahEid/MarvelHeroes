//
//  CharacterSourceCell.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class CharacterSourceCell: UICollectionViewCell {

    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    
    static let reuseIdentifier = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
