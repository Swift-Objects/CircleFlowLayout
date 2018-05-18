//
//  BQSWaterCollectionView.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class BQSWaterCollectionView: UIView {

    var collectionView: UICollectionView?
    var numberItemOfOneLine: Int?                   //每行的item的个数
    var lineSpacing:CGFloat?                        //行间距
    var interitemSpacing: CGFloat?                  //列间距
    var sectionPadding: CGFloat?                    //距屏幕的间距
    var itemHeight: CGFloat?                        //item高
    var layout = CollectionViewWaterFlowLayout()    //layout
    var imagesArray: Array<WaterModel> = []         //获取数据model
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addCollectionView(){
        layout.imagesArray = self.imagesArray
        self.numberItemOfOneLine = (self.numberItemOfOneLine != nil) ? self.numberItemOfOneLine! : 4
        self.interitemSpacing = (self.interitemSpacing != nil) ? self.interitemSpacing! : 3.0
        self.lineSpacing = (self.lineSpacing != nil) ? self.lineSpacing : 3.0
        self.sectionPadding = (self.sectionPadding != nil) ? self.sectionPadding! : 7.5
        
        layout.minimumLineSpacing = self.lineSpacing!
        layout.minimumInteritemSpacing = self.interitemSpacing!
        layout.sectionInset = UIEdgeInsets(top: 0, left: self.sectionPadding!, bottom: 0, right: self.sectionPadding!)
        let padding = self.sectionPadding! * 2
        let spacing = CGFloat(self.numberItemOfOneLine! - 1)
        let interval = self.bounds.width - padding - self.interitemSpacing! * spacing
        let itemWidth = interval / CGFloat(self.numberItemOfOneLine!)
        self.itemHeight = (self.itemHeight != nil) ? self.itemHeight : itemWidth
        layout.itemSize = CGSize(width: itemWidth, height: self.itemHeight!)
        
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(UINib.init(nibName: "WaterCell", bundle: nil), forCellWithReuseIdentifier: "WaterCell")
        self.addSubview(self.collectionView!)
    }
}
