//
//  ViewController.swift
//  SushiBarControl
//
//  Created by Jonathan Zong on 9/17/15.
//  Copyright (c) 2015 Jonathan Zong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view = SushiBarView(frame: CGRect(x: 0, y: self.view.frame.height - 150, width: self.view.frame.width, height: 100))
        view.setPageImages([UIImage(named:"photo1.png")!,
            UIImage(named:"photo2.png")!,
            UIImage(named:"photo3.png")!,
            UIImage(named:"photo4.png")!,
            UIImage(named:"photo5.png")!])
        
        view.setSelectedIndex(2)
        
        view.button?.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)

        
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonPressed(sender:UIButton!) {
        println("Button pressed")
    }

}

