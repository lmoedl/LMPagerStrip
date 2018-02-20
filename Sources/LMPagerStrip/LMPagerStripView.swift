//
//  PagerStripView.swift
//  PagerStrip
//
//  Created by Lothar Mödl on 14.02.18.
//  Copyright © 2018 Lothar Mödl. All rights reserved.
//

import UIKit

class LMPagerStripView: UIView {
    
    var pagerStripBackgroundColor: UIColor = UIColor.red {
        didSet {
            collectionView.backgroundColor = pagerStripBackgroundColor
        }
    }
    var items: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
            if collectionView.indexPathsForSelectedItems?.count == 0 {
                collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
            }
        }
    }
    var scrollIndicator: UIView?
    
    var barItemSelectedColor: UIColor = UIColor.white
    var barItemUnselectedColor: UIColor = UIColor.gray
    
    var delegate: CellSelectorDelegate?
    
    private var heightConstraint: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.register(LMPagerStripCell.self, forCellWithReuseIdentifier: "cell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = pagerStripBackgroundColor
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCollectionView()
    }
    
    init(items: [UIImage]) {
        super.init(frame: .zero)
        self.items = items
        addCollectionView()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCollectionView() {
        self.addSubview(collectionView)
        self.translatesAutoresizingMaskIntoConstraints = false
        addCollectionViewConstraints()
    }
    
    
    private func addCollectionViewConstraints() {
        heightConstraint = collectionView.heightAnchor.constraint(equalTo: (self.collectionView.superview?.heightAnchor)!)
        heightConstraint?.isActive = true
        collectionView.widthAnchor.constraint(equalTo: (self.collectionView.superview?.widthAnchor)!).isActive = true
        
        collectionView.leftAnchor.constraint(equalTo: (self.collectionView.superview?.leftAnchor)!).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: (self.collectionView.superview?.bottomAnchor)!).isActive = true
    }
    
    func setupScrollIndicator(){
        scrollIndicator = UIView(frame: CGRect(x: collectionView.frame.origin.x, y: collectionView.frame.height - 5, width: frame.width / CGFloat(items.count), height: 5))
        scrollIndicator?.backgroundColor = barItemSelectedColor
        collectionView.addSubview(scrollIndicator!)
    }
    
}

extension LMPagerStripView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LMPagerStripCell
        cell.backgroundColor = pagerStripBackgroundColor
        cell.image = items[indexPath.item]
        cell.selectedTintColor = barItemSelectedColor
        cell.unselectedTintColor = barItemUnselectedColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath.item)
    }
}

extension LMPagerStripView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return isLargeTitlesEnabled ? CGSize(width: frame.width / CGFloat(items.count), height: frame.height/2) :
        return CGSize(width: frame.width / CGFloat(items.count), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
