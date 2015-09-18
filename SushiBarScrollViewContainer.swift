//
//  SushiBarScrollViewContainer.swift
//  SushiBarControl
//
//  Created by Jonathan Zong on 9/18/15.
//  Copyright (c) 2015 Jonathan Zong. All rights reserved.
//

import UIKit

class SushiBarScrollViewContainer: UIView {
    var scrollView: SushiBarScrollView?
    
    convenience init(frame: CGRect, pageImages: [UIImage]) {
        self.init(frame: frame)
        let minDim = min(frame.height, frame.width)
        let squareFrame = CGRect(x: 0, y: 0, width: minDim, height: minDim)
        scrollView = SushiBarScrollView(frame: squareFrame, pageImages: pageImages)
        self.addSubview(scrollView!)
        self.clipsToBounds = true
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        
        return view
    }
}