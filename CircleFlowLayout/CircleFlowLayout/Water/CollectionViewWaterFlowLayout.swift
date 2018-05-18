//
//  CollectionViewWaterFlowLayout.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class CollectionViewWaterFlowLayout: UICollectionViewFlowLayout {

    var allAttributes: Array<Any> = []
    var sectionDic: Dictionary<String, String> = [:]
    var pageNumber: Int? //每个分区的页数
    var lineNumber: Int? //每行的个数
    var rowNumber: Int?  //每列的个数
    
    var heightArray: Array<CGFloat> = [0, 0, 0]
    var imagesArray: Array<WaterModel> = []
    
    
    //准备工作,获取cell的frame
    override func prepare() {
        super.prepare()
        let section = self.collectionView?.numberOfSections
        for section1 in 0...section! - 1 {
            
            let count = self.collectionView?.numberOfItems(inSection: section1);
            for row1 in 0...count! - 1 {
                let index = IndexPath(item: row1, section: section1)
                let attributes = self.layoutAttributesForItem(at: index)!
                self.allAttributes.append(attributes)
            }
        }
    }
    
    //返回collection的size
    override var collectionViewContentSize: CGSize {
        var height: CGFloat = 0
        for height1 in heightArray {
            if height < height1 {
                height = height1
            }
        }
        return CGSize(width: (self.collectionView?.frame.size.width)!, height: height)
    }
    
    //重置每一个cell的frame
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!

        if(attributes.representedElementKind == nil) {
            var mini: CGFloat = 0 //最低高度
            var list: Int = 0 //最低高度的列
            
            for num in 0...2 {
                let figure = heightArray[num]
                if num == 0 {
                    mini = figure
                    list = num
                } else {
                    if mini > figure {
                        mini = figure
                        list = num
                    }
                }
            }
            //attributes 的宽度
            let itemW = attributes.frame.size.width;
            
            let model = self.imagesArray[indexPath.row]
            let imageName = model.imageName
            let image = UIImage(named: imageName!)
            let size = image?.size
            let height = itemW * (size?.height)! / (size?.width)!
            heightArray[list] = mini + 15 + height
            
            attributes.frame = CGRect(x: 7.5 + (15 + itemW) * CGFloat(list), y: mini + 15, width: itemW, height: height)
            
            
        }
        return attributes
    }
    
    //返回每个cell的frame
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.allAttributes as? [UICollectionViewLayoutAttributes]
    }

}
