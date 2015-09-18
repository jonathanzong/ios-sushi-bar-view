//
//  ViewController.swift
//  SushiBarControl
//
//  Created by Jonathan Zong on 9/17/15.
//  Copyright (c) 2015 Jonathan Zong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewD {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view = SushiBarScrollViewContainer(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200),
            pageImages:
            [UIImage(named:"photo1.png")!,
            UIImage(named:"photo2.png")!,
            UIImage(named:"photo3.png")!,
            UIImage(named:"photo4.png")!,
            UIImage(named:"photo5.png")!])
        
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

