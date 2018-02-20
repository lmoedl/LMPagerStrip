//
//  LMPagerStripViewController.swift
//  PagerStrip
//
//  Created by Lothar Mödl on 15.02.18.
//  Copyright © 2018 Lothar Mödl. All rights reserved.
//

import UIKit

protocol CellSelectorDelegate {
    func didSelectItem(at index: Int)
}

open class LMPagerStripViewController: UIPageViewController {
    
    var pages: [UIViewController] = [] {
        didSet {
            setSelectedPage(0)
        }
    }
    
    var pagerStripIcons: [UIImage] = [] {
        didSet {
            pagerStrip.items = pagerStripIcons
        }
    }
    
    private lazy var pagerStrip: LMPagerStripView = {
        let pagerStrip = LMPagerStripView(items: pagerStripIcons)
        pagerStrip.delegate = self
        return pagerStrip
    }()
    
    open var barItemSelectedColor: UIColor = UIColor.white {
        didSet {
            pagerStrip.barItemSelectedColor = barItemSelectedColor
        }
    }
    open var barItemUnselectedColor: UIColor = UIColor.gray {
        didSet {
            pagerStrip.barItemUnselectedColor = barItemUnselectedColor
        }
    }
    
    open var pagerStripBackgroundColor: UIColor = UIColor.red {
        didSet {
            pagerStrip.pagerStripBackgroundColor = pagerStripBackgroundColor
        }
    }
    
    private var pageScrollView: UIScrollView?
    private var currentPageIndex: Int = 0
    private var constantPagerStripHeightConstraint: NSLayoutConstraint?
    private var pagerStripHeigthConstraint: NSLayoutConstraint?
    private var originalNavigationbarHeight: CGFloat = 0
    
    public init(pages: [UIViewController], icons: [UIImage]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        if pages.count != icons.count {
            fatalError("It needs to be the same amount of ViewControllers and icons!")
        }
        
        self.pages = pages
        self.pagerStripIcons = icons
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        setupPagerStrip()
        setSelectedPage(0)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupPagerStrip() {
        navigationController?.navigationBar.isTranslucent = true
        //navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.addSubview(pagerStrip)
        
        //Save navbar height for reset after rotation
        originalNavigationbarHeight = (navigationController?.navigationBar.frame.height)!
        addConstraints()
        getContentScrollView()
    }
    
    private func addConstraints() {
        pagerStrip.widthAnchor.constraint(equalTo: (self.navigationController?.navigationBar.widthAnchor)!).isActive = true
        if #available(iOS 11.0, *) {
            //Check if largeTitles is enabled and set fixed height, if not, use the whole height of the navigationBar
            if (navigationController?.navigationBar.prefersLargeTitles)! {
                constantPagerStripHeightConstraint = pagerStrip.heightAnchor.constraint(equalToConstant: 44)
                constantPagerStripHeightConstraint?.isActive = true
            }else {
                pagerStripHeigthConstraint = pagerStrip.heightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.heightAnchor)!)
                pagerStripHeigthConstraint?.isActive = true
            }
        } else {
            pagerStripHeigthConstraint = pagerStrip.heightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.heightAnchor)!)
            pagerStripHeigthConstraint?.isActive = true
        }
        pagerStrip.leftAnchor.constraint(equalTo: (navigationController?.navigationBar.leftAnchor)!).isActive = true
        pagerStrip.bottomAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
    }
    
    
    override open func viewDidLayoutSubviews() {
        //TODO: If possible find better solution --> pagerstrip should setup scroll indicator by it self
        if pagerStrip.scrollIndicator?.superview == nil {
            pagerStrip.setupScrollIndicator()
        }
    }

    func setSelectedPage(_ page: Int, _ direction: UIPageViewControllerNavigationDirection = .forward, _ animated: Bool = true){
        setViewControllers([pages[page]], direction: direction, animated: animated)
    }

    //Find content scrollview of PageViewController to set ContentViewController insets and get the scroll progress
    private func getContentScrollView(){
        self.pageScrollView = view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
        self.pageScrollView?.delegate = self
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Height adjustments when device is rotated
        if #available(iOS 11.0, *) {
            if let isLargeTitles = navigationController?.navigationBar.prefersLargeTitles {
                if isLargeTitles {
                    if UIDevice.current.orientation.isLandscape {
                        constantPagerStripHeightConstraint?.isActive = false
                        pagerStripHeigthConstraint = pagerStrip.heightAnchor.constraint(equalTo: (self.navigationController?.navigationBar.heightAnchor)!)
                        pagerStripHeigthConstraint?.isActive = true
                    }else {
                        pagerStripHeigthConstraint?.isActive = false
                        constantPagerStripHeightConstraint?.isActive = true
                        
                        //Reset navigationbar to original height (hack)
                        navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: originalNavigationbarHeight).isActive = true
                    }
                }
            }
        }
        pagerStrip.collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK - PageViewControllerDataSource

extension LMPagerStripViewController: UIPageViewControllerDataSource{
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex != 0 {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            }
        }
        return nil
    }
}

// MARK - PageViewControllerDelegate

extension LMPagerStripViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        currentPageIndex = pages.index(of: pageContentViewController)!
        print("currentPageIndex: \(currentPageIndex)")
        pagerStrip.collectionView.selectItem(at: IndexPath(item: currentPageIndex, section: 0), animated: false, scrollPosition: [])
        
    }
}

// MARK: - ScrollViewDelegate

extension LMPagerStripViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = (scrollView.contentOffset.x - view.frame.size.width) / CGFloat(pages.count)
        pagerStrip.scrollIndicator?.frame.origin.x = scrollPosition + CGFloat(currentPageIndex) * (pagerStrip.scrollIndicator?.frame.width)!
    }
}

// MARK: - CellSelectorDelegatre
extension LMPagerStripViewController: CellSelectorDelegate {
    func didSelectItem(at index: Int) {
        if currentPageIndex < index {
            setSelectedPage(index, .forward, false)
        }else {
            setSelectedPage(index, .reverse, false)
        }
        currentPageIndex = index
        pagerStrip.scrollIndicator?.frame.origin.x = CGFloat(currentPageIndex) * (pagerStrip.scrollIndicator?.frame.width)!
    }
}

