//
//  UICollectionView.swift
//  MarvelHeroes
//
//  Created by Abdallah Eid on 8/4/19.
//  Copyright © 2019 Abdallah Eid. All rights reserved.
//

import Foundation
import UIKit

// these are 2 properties for collection view to have the array of source directly
// ex: comicsCollectionView has its comics array and seriesCollectionView has its series array
// and this to help in reload collection view in cellForItemAt in file /Extensions/CharacterDetailsViewController+CollectionView

fileprivate var sourceArray_FILEPRIVATE: [ObjectIdentifier:[CharacterSourceResponse]] = [:]
fileprivate var sourceArray_DEFAULT: [CharacterSourceResponse] = [CharacterSourceResponse]()

fileprivate var selectedSource_FILEPRIVATE: [ObjectIdentifier: CharacterSourceType] = [:]
fileprivate var selectedSource_DEFAULT: CharacterSourceType = .comics

extension UICollectionView {
    var sourceArray: [CharacterSourceResponse] {
        get {return sourceArray_FILEPRIVATE[ObjectIdentifier(self)] ?? sourceArray_DEFAULT}
        set {sourceArray_FILEPRIVATE[ObjectIdentifier(self)] = newValue}
    }
    
    var selectedSource: CharacterSourceType{
        get {return selectedSource_FILEPRIVATE[ObjectIdentifier(self)] ?? selectedSource_DEFAULT}
        set {selectedSource_FILEPRIVATE[ObjectIdentifier(self)] = newValue}
    }
}
