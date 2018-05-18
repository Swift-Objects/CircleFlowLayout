//
//  CircleFlowLayout.swift
//  Protocol
//
//  Created by lemo on 2018/5/17.
//  Copyright © 2018年 wangli. All rights reserved.
// 圆形排列

import UIKit

class CircleFlowLayout: UICollectionViewFlowLayout {
    
    var attrsArr: Array<UICollectionViewLayoutAttributes>? = []

    override func prepare() {
        super.prepare()
        
        let count = self.collectionView?.numberOfItems(inSection: 0)
        for num in 0...count! - 1 {
            let indexPath = IndexPath(row: num, section: 0)
            let attrs = layoutAttributesForItem(at: indexPath)!
            self.attrsArr?.append(attrs)
        }
    }
    

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //总数
        let count = self.collectionView?.numberOfItems(inSection: 0)
        //角度
        let angle = 2 * CGFloat(Double.pi) / CGFloat(count!) * CGFloat(indexPath.row)
        //半径
        let radius: CGFloat = 100
        //圆心位置
        let centerX = (self.collectionView?.frame.width)! / 2
        let centerY = (self.collectionView?.frame.height)! / 2
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.center = CGPoint(x: centerX + radius * sin(angle), y: centerY + radius * cos(angle))
        if count == 1 {
            attrs.size = CGSize(width: 200, height: 200)
        } else {
            attrs.size = CGSize(width: 50, height: 50)
        }
        return attrs
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArr
    }
}
