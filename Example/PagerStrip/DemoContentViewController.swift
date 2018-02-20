//
//  DemoContentViewController.swift
//  PagerStrip
//
//  Created by Lothar Mödl on 20.02.18.
//  Copyright © 2018 Lothar Mödl. All rights reserved.
//

import UIKit

class DemoContentViewController: UIViewController {
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentImageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
