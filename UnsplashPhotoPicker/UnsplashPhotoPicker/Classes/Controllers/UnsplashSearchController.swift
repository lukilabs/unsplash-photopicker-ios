//
//  UnsplashSearchController.swift
//  UnsplashPhotoPicker
//
//  Created by Bichon, Nicolas on 2018-12-10.
//  Copyright © 2018 Unsplash. All rights reserved.
//

import UIKit

class UnsplashSearchController: UISearchController {
    lazy var customSearchBar = CustomSearchBar(frame: CGRect.zero)

    override var searchBar: UISearchBar {
        customSearchBar.showsCancelButton = false
        customSearchBar.searchTextField.backgroundColor = .secondarySystemBackground
        return customSearchBar
    }
}

class CustomSearchBar: UISearchBar {
    override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
        super.setShowsCancelButton(false, animated: false)
    }
    
    public override var traitCollection: UITraitCollection {
        get {
            if #available(iOS 14.0, macCatalyst 14.0, *), super.traitCollection.userInterfaceIdiom == .mac {
                return UITraitCollection(traitsFrom: [super.traitCollection, UITraitCollection(userInterfaceIdiom: .pad)])
            }
            else {
                return super.traitCollection
            }
        }
    }
}
