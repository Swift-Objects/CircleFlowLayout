//
//  CircleViewController.swift
//  Protocol
//
//  Created by lemo on 2018/5/17.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

enum LayoutType {
    case Normal
    case Circle
    case Semicircle
    case TopSemicircle
}

class CircleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let identifier = "CircleCollectionViewCell"
    var dataSource: Array<CircleModel> = []
    var collectionView: UICollectionView?
    var layout: UICollectionViewFlowLayout?
    var type = LayoutType.Normal
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "DarkBlue")
        
        addDataSource()
        addCollection()
        addChangeBtn()
    }
    
    func addChangeBtn() {
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.center = self.view.center
        btn.setTitle("散开", for: .normal)
        btn.backgroundColor = UIColor.init(named: "DarkBlue")
        btn.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func changeAction() {
        switch type {
        case .Circle:
            collectionView?.setCollectionViewLayout(CircleFlowLayout(), animated: true)
            type = .Semicircle
        case .Semicircle:
            collectionView?.setCollectionViewLayout(SemicircleFlowLayout(), animated: true)
            type = .TopSemicircle
        case .TopSemicircle:
            collectionView?.setCollectionViewLayout(TopSemicircleFlowLayout(), animated: true)
            type = .Normal
        default:
            collectionView?.setCollectionViewLayout(layout!, animated: true)
            type = .Circle
        }
    }
    
    func addDataSource() {
        for _ in 0...25 {
            let model = CircleModel()
            model.imageName = "01.png"
            dataSource.append(model)
        }
        collectionView?.reloadData()
    }
    
    func addCollection() {
        layout = UICollectionViewFlowLayout()
        layout!.minimumLineSpacing = 5
        layout!.minimumInteritemSpacing = 5
        layout?.scrollDirection = .horizontal
        let width = BQSScreenWidth / CGFloat(5)
        layout!.itemSize = CGSize(width: width, height: width)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: BQSScreenWidth, height: BQSScreenWidth), collectionViewLayout: layout!)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib.init(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionView?.backgroundColor = .white
        self.view.addSubview(collectionView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CircleCollectionViewCell
        cell.setModel(model: dataSource[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
