//
//  ViewController.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

//MARK: 屏幕宽度
let BQSScreenWidth = UIScreen.main.bounds.width
//MARK: 屏幕高度
let BQSScreenHeight = UIScreen.main.bounds.height
class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    //cell 宽度
    let itemWidth: CGFloat = (BQSScreenWidth - 15 * 7 - 3 * 2) / 8
    
    var dataSource: Array<BQSShowFaceModel> = []
    var dataSourceList: Array<Any> = []
    //整个表情的俯视图
    var faceBackgroundView: UIView?
    
    //页面控制器
    var pageControl: BQSPageControllerView?
    
    //显示表情cell
    let cellIdentifier = "BQSShowFaceCell"
    
    var faceCollectionView: BQSShowCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor.init(named: "DarkBlue")
        
        addFaceBackgroundView()
        addDataSource()
        addCollection()
        addFaceButtons()
    }
    
    
    @IBAction func intoWater(_ sender: Any) {
        let water = WaterViewController()
        self.navigationController?.pushViewController(water, animated: true)
    }
    @IBAction func intoCircle(_ sender: Any) {
        let circle = CircleViewController()
        self.navigationController?.pushViewController(circle, animated: true)
    }
    
    func addDataSource() {
        let filePath = Bundle.main.path(forResource: "FaceList", ofType: "plist")
        let url = URL(fileURLWithPath: filePath!)
        let faceData = NSDictionary(contentsOf: url)
        let keys = faceData?.allKeys
        var num = 0
        
        for key in keys! {
            let model = BQSShowFaceModel()
            model.imageName = (faceData?[key] as! String)
            model.title = String(num)
            dataSource.append(model)
            num += 1
        }
        dataSourceList.append(dataSource)
        dataSourceList.append(dataSource)
        let count = dataSource.count
        let numberOfPage = 24
        var page: Int = 0
        if count % numberOfPage == 0 {
            page = count / numberOfPage
        } else {
            page = count / numberOfPage + 1
        }
        addPageControl(number: page)
    }
    
    func addCollection() {
        let collectionViewHeight: CGFloat = 150
        faceCollectionView = BQSShowCollectionView(frame: CGRect(x: 0, y: 0, width: BQSScreenWidth, height: collectionViewHeight))
        faceCollectionView?.cellIdentifier = cellIdentifier
        faceCollectionView?.numberItemOfOneLine = 8
        faceCollectionView?.interitemSpacing = 15
        faceCollectionView?.lineSpacing = 15
        faceCollectionView?.addCollectionView()
        faceCollectionView?.layout.scrollDirection = .horizontal
        faceCollectionView?.layout.pageNumber = 24
        faceCollectionView?.layout.lineNumber = 3
        faceCollectionView?.layout.rowNumber = 8
        faceCollectionView?.collectionView?.isPagingEnabled = true
        faceCollectionView?.collectionView?.delegate = self
        faceCollectionView?.collectionView?.dataSource = self
        faceCollectionView?.collectionView?.showsHorizontalScrollIndicator = false
        faceCollectionView?.collectionView?.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        faceBackgroundView?.addSubview(faceCollectionView!)
    }
    
    //MARK: UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BQSShowFaceCell
        let data = dataSourceList[indexPath.section] as! Array<BQSShowFaceModel>
        cell.setModel(model: data[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSourceList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = dataSourceList[section] as! Array<BQSShowFaceModel>
        
        return data.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("index:\(indexPath)")
//        let dataList = dataSourceList[indexPath.sectixon] as! Array<BQSShowFaceModel>
//        let numberPage = dataList.count / 24
        let currentPageNumber = indexPath.row / 24
        
//        addPageControl(number: numberPage)
        pageControl?.showCurrentPage(number: currentPageNumber)
    }
    
    func addFaceBackgroundView() {
        let backgroundViewHeight: CGFloat = 220
        
        faceBackgroundView = UIView(frame: CGRect(x: 0, y: BQSScreenHeight - backgroundViewHeight - 34, width: BQSScreenWidth, height: backgroundViewHeight))
        faceBackgroundView?.backgroundColor = UIColor.init(hex: "F5F5F7")
        self.view.addSubview(faceBackgroundView!)
        let count = dataSource.count
        let numberOfPage = 24
        var page: Int = 0
        if count % numberOfPage == 0 {
            page = count / numberOfPage
        } else {
            page = count / numberOfPage + 1
        }
        addPageControl(number: page)
    }

    func addPageControl(number: Int) {
        if pageControl == nil {
            pageControl = BQSPageControllerView(frame: CGRect(x: 0, y: 150, width: BQSScreenWidth, height: 30))
            faceBackgroundView?.addSubview(pageControl!)
        }
        pageControl?.numberOfPage(numebr: number)
        pageControl?.showCurrentPage(number: 0)
    }
    
    func addFaceButtons() {
        let faceBagOptionsView = FaceBagOptionsView(frame: CGRect(x: 0, y: 180, width: BQSScreenWidth, height: 40))
        faceBagOptionsView.faceDataSource = ["d_aini", "d_bizui", "01", "02", "d_bizui", "01", "02", "d_bizui", "01", "02", "d_bizui", "01"]
        faceBagOptionsView.addFaceButton()
        faceBagOptionsView.delegate = self
        faceBackgroundView?.addSubview(faceBagOptionsView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK: FaceBagOptionsViewDelegate
extension ViewController: FaceBagOptionsViewDelegate {
    func selectedFace(index: Int) {
        print("打脸:\(index)")
    }
    
    func addFaceAction() {
        print("添加")
    }
    
    func settingFaceAction() {
        print("设置")
    }
}

