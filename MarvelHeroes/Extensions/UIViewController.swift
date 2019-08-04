//
//  UIViewController.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/3/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title:String,message:String,completion: ((UIAlertAction)->Void)? = nil )  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default,handler:completion)
        alert.addAction(okAction)
        
        self.present(alert , animated:true)
    }
}
