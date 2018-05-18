//
//  CollectionViewFlowLayout.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//  自定义cell的layout 可以让cell在水平滚动的时候,cell水平排列

import UIKit

class BQSCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var allAttributes: Array<Any> = []
    var sectionDic: Dictionary<String, String> = [:]
    var pageNumber: Int? //每个分区的页数
    var lineNumber: Int? //每行的个数
    var rowNumber: Int?  //每列的个数
    var pageOSection: Array<Int>? = []
    var lastSectionPageNumber = 0
    var currentPage = 0
    
    //准备工作,获取cell的frame
    override func prepare() {
        super.prepare()
        let section = self.collectionView?.numberOfSections
        for section1 in 0...section! - 1 {
            pageOSection?.append(0)
            let count = self.collectionView?.numberOfItems(inSection: section1)
            var page1 = count! / pageNumber!
            if count! % pageNumber! != 0 {
                page1 = page1 + 1
            }
            pageOSection?[section1] = page1 + lastSectionPageNumber
            lastSectionPageNumber = page1
            for row1 in 0...count! - 1 {
                let index = IndexPath(item: row1, section: section1)
                let attributes = self.layoutAttributesForItem(at: index)!
                self.allAttributes.append(attributes)
            }
        }
    }
    
    //返回collection的size
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(currentPage + 1) * (self.collectionView?.frame.size.width)!, height: self.collectionView!.contentSize.height)
    }
    
    //重置每一个cell的frame
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!
        
        
        
        if(attributes.representedElementKind == nil) {
            //attributes 的宽度
            let itemW = attributes.frame.size.width;
            //attributes 的高度
            let itemH = attributes.frame.size.height;
            
            var page = indexPath.row / (lineNumber! * rowNumber!)
            if indexPath.section > 0 {
                page = page + pageOSection![indexPath.section - 1]
            }
            currentPage = page
            let remainder = indexPath.row % (lineNumber! * rowNumber!)
            //page根据不同的分区,加上之前的分区的页数
            let X = 7.5 + (15 + itemW) * CGFloat(remainder % rowNumber!) + CGFloat(page) * BQSScreenWidth
            let Y = 7.5 + (15 + itemW) * CGFloat(remainder / rowNumber!)

            attributes.frame = CGRect(x: X, y: Y, width: itemW, height: itemH)
        }
        return attributes
    }
    
    //返回每个cell的frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.allAttributes as? [UICollectionViewLayoutAttributes]
    }
    
    
}
