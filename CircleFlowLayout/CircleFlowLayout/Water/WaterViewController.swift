//
//  WaterViewController.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit
//MARK: 屏幕宽度
//let BQSScreenWidth = UIScreen.main.bounds.width
////MARK: 屏幕高度
//let BQSScreenHeight = UIScreen.main.bounds.height
////cell 宽度
//let itemWidth: CGFloat = (BQSScreenWidth - 15 * 7 - 3 * 2) / 8


var dataSource1: Array<WaterModel> = []

//显示表情cell
let cellIdentifier1 = "WaterCell"
class WaterViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{

    var faceCollectionView: BQSWaterCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDataSource()
        addCollection()
    }
    
    
    func addDataSource() {
        let filePath = Bundle.main.path(forResource: "WaterImageList", ofType: "plist")
        let url = URL(fileURLWithPath: filePath!)
        let faceData = NSDictionary(contentsOf: url)
        let keys = faceData?.allKeys
        var num = 0
        
        for key in keys! {
            let model = WaterModel()
            model.imageName = faceData?[key] as? String
            model.title = String(num)
            dataSource1.append(model)
            num += 1
        }
    }
    
    func addCollection() {
        let collectionViewHeight: CGFloat = BQSScreenHeight - navigationHeight()
        faceCollectionView = BQSWaterCollectionView(frame: CGRect(x: 0, y: navigationHeight(), width: BQSScreenWidth, height: collectionViewHeight))
        faceCollectionView?.imagesArray = dataSource1
        faceCollectionView?.numberItemOfOneLine = 3
        faceCollectionView?.interitemSpacing = 15
        faceCollectionView?.lineSpacing = 15
        faceCollectionView?.addCollectionView()
        faceCollectionView?.layout.pageNumber = 3
        faceCollectionView?.layout.lineNumber = 3
        faceCollectionView?.layout.rowNumber = 3
        faceCollectionView?.collectionView?.delegate = self
        faceCollectionView?.collectionView?.dataSource = self
        faceCollectionView?.collectionView?.showsHorizontalScrollIndicator = false
        faceCollectionView?.collectionView?.register(UINib.init(nibName: cellIdentifier1, bundle: nil), forCellWithReuseIdentifier: cellIdentifier1)
        
        self.view?.addSubview(faceCollectionView!)
    }
    
    //MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier1, for: indexPath) as! WaterCell
        
        cell.setModel(model: dataSource1[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource1.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK:导航栏和状态栏的高度和
    func navigationHeight() -> CGFloat {
        return (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
