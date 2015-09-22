//
//  SushiBarView.swift
//  SushiBarControl
//
//  Created by Jonathan Zong on 9/18/15.
//  Copyright (c) 2015 Jonathan Zong. All rights reserved.
//

import UIKit

class SushiBarView: UIView {
    var scrollView: SushiBarScrollView?
    var button: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let minDim = min(frame.height, frame.width)
        let squareFrame = CGRect(x: frame.width / 2 - minDim / 2, y: 0, width: minDim, height: minDim)
        scrollView = SushiBarScrollView(frame: squareFrame)
        self.addSubview(scrollView!)
        self.clipsToBounds = true
        
        let newButton = UIButton(frame: squareFrame)
        newButton.frame.origin.x = 0
        newButton.layer.cornerRadius = newButton.bounds.size.height / 2.0
        newButton.layer.borderWidth = 5.0
        newButton.layer.masksToBounds = false
        newButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        button = newButton
        scrollView!.button = button!
        scrollView!.addSubview(button!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setPageImages(pageImages: [UIImage]) {
        scrollView?.pageImages = pageImages
        
        let pageCount = pageImages.count
        
        // Set up the array to hold the views for each page
        while scrollView?.pageViews.count < pageCount {
            scrollView?.pageViews.append(nil)
        }
        
        // Set up the content size of the scroll view
        if let pagesScrollViewSize = scrollView?.frame.size {
            scrollView?.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        }
        
        // Load the initial set of pages that are on screen
        scrollView?.loadVisiblePages()
    }
    
    func setSelectedIndex(index: Int) {
        self.scrollView?.contentOffset = CGPoint(x: scrollView!.frame.width * CGFloat(index), y: scrollView!.contentOffset.y)
    }
}