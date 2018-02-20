//
//  ViewController.swift
//  PagerStrip
//
//  Created by Lothar Mödl on 13.02.18.
//  Copyright © 2018 Lothar Mödl. All rights reserved.
//

import UIKit
import LMPagerStrip

class ViewController: UIViewController {
    
    var pagerStripVC: LMPagerStripViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Instantiate content ViewControllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "page") as! DemoContentViewController
        vc1.image = #imageLiteral(resourceName: "img1")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "page") as! DemoContentViewController
        vc2.image = #imageLiteral(resourceName: "img2")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "page") as! DemoContentViewController
        vc3.image = #imageLiteral(resourceName: "img3")
        let vc4 = storyboard.instantiateViewController(withIdentifier: "page") as! DemoContentViewController
        vc4.image = #imageLiteral(resourceName: "img4")
        
        pagerStripVC = LMPagerStripViewController(pages: [vc1, vc2, vc3, vc4], icons: [#imageLiteral(resourceName: "ic_fastcheck"), #imageLiteral(resourceName: "ic_maintenance"), #imageLiteral(resourceName: "ic_commonmistakes"), #imageLiteral(resourceName: "ic_intensivecheck")])
        pagerStripVC.pagerStripBackgroundColor = #colorLiteral(red: 0.9764705882, green: 0.3882352941, blue: 0.1960784314, alpha: 1)
        pagerStripVC.barItemSelectedColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pagerStripVC.barItemUnselectedColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        
        self.view.addSubview(pagerStripVC.view)
        self.addChildViewController(pagerStripVC)
        pagerStripVC.didMove(toParentViewController: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

