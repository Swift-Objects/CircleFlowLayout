//
//  SemicircleFlowLayout.swift
//  Protocol
//
//  Created by lemo on 2018/5/18.
//  Copyright © 2018年 wangli. All rights reserved.
//  右半圆排列

import UIKit

class SemicircleFlowLayout: UICollectionViewFlowLayout {
    
    var attrsArray: Array<UICollectionViewLayoutAttributes>? = []
    //添加之前的UICollectionViewLayoutAttributes
    override func prepare() {
        //总数
        let count = self.collectionView?.numberOfItems(inSection: 0)
        //遍历
        for num in 0...count! - 1 {
            //获取每一个indexPath的attrs
            let indexPath = IndexPath(row: num, section: 0)
            let attrs = self.layoutAttributesForItem(at: indexPath)
            attrsArray?.append(attrs!)
        }
    }
    
    //重新计算UICollectionViewLayoutAttributes
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //
        let count = self.collectionView?.numberOfItems(inSection: 0)
        //角度
        let angle = CGFloat(Double.pi) / CGFloat(count!) * CGFloat(indexPath.row)
        //半径
        let radius: CGFloat = 100
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
        return attrsArray
    }
}
