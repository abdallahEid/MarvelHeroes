//
//  SearchCell.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/2/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var characterLabelName: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    static let reuseIdentifier = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
