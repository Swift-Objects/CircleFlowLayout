//
//  BQSPageControllerView.swift
//  FaceStore-Swift
//
//  Created by lemo on 2018/5/11.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class BQSPageControllerView: BQSXIBView {

    @IBOutlet weak var pageControl: UIPageControl!
    
    func numberOfPage(numebr: Int) {
        pageControl.numberOfPages = numebr
        
    }
    
    func showCurrentPage(number: Int) {
        pageControl.currentPage = number
    }

}
