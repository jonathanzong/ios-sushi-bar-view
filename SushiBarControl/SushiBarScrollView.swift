//
//  SushiBarScrollView.swift
//  SushiBarControl
//
//  Created by Jonathan Zong on 9/17/15.
//  Copyright (c) 2015 Jonathan Zong. All rights reserved.
//

import UIKit

class SushiBarScrollView: UIScrollView {
    
    class _DelegateProxy: NSObject, UIScrollViewDelegate {
        weak var _userDelegate: UIScrollViewDelegate?
        
        override func respondsToSelector(aSelector: Selector) -> Bool {
            return super.respondsToSelector(aSelector) || (_userDelegate?.respondsToSelector(aSelector) == true)
        }
        
        override func forwardingTargetForSelector(aSelector: Selector) -> AnyObject? {
            if _userDelegate?.respondsToSelector(aSelector) == true {
                return _userDelegate
            }
            else {
                return super.forwardingTargetForSelector(aSelector)
            }
        }
        
        func scrollViewDidScroll(scrollView: UIScrollView) {
            if let sushiBar = scrollView as? SushiBarScrollView {
                sushiBar.didScroll()
            }
            _userDelegate?.scrollViewDidScroll?(scrollView)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var _delegateProxy =  _DelegateProxy()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.delegate = _delegateProxy
        
        self.pagingEnabled = true
        self.clipsToBounds = false
        self.showsHorizontalScrollIndicator = false
    }
    
    override var delegate:UIScrollViewDelegate? {
        get {
            return _delegateProxy._userDelegate
        }
        set {
            self._delegateProxy._userDelegate = newValue
        }
    }
    
    //
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    var button: UIButton?
    
    func loadPage(page: Int) {
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = self.bounds
            frame.size.height = min(frame.size.width, frame.size.height)
            frame.size.width = frame.size.height
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            frame = CGRectInset(frame, 10.0, 10.0)
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFill
            newPageView.frame = frame
            
            newPageView.layer.borderWidth = 3.0
            newPageView.layer.masksToBounds = false
            newPageView.layer.borderColor = UIColor.whiteColor().CGColor
            newPageView.layer.cornerRadius = newPageView.frame.size.height / 2
            newPageView.clipsToBounds = true
            
            self.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        
        
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
        
    }
    
    func loadVisiblePages() {
        
        // First, determine which page is currently visible
        let pageWidth = self.frame.size.width
        let page = Int(floor((self.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for var index = firstPage; index <= lastPage; ++index {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func didScroll() {
        loadVisiblePages()
        button?.frame.origin = self.contentOffset
    }
}