//
//  PagerStripCell.swift
//  PagerStrip
//
//  Created by Lothar Mödl on 14.02.18.
//  Copyright © 2018 Lothar Mödl. All rights reserved.
//

import UIKit

class LMPagerStripCell: UICollectionViewCell {
    
    var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    var selectedTintColor: UIColor = .white {
        didSet {
            imageView.tintColor = isSelected ? selectedTintColor : unselectedTintColor
        }
    }
    var unselectedTintColor: UIColor = .gray {
        didSet {
            imageView.tintColor = isSelected ? selectedTintColor : unselectedTintColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? selectedTintColor : unselectedTintColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? selectedTintColor : unselectedTintColor
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = unselectedTintColor
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: frame.height/2).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: frame.height/2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
