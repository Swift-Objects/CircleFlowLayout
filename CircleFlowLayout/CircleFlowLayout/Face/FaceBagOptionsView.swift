//
//  FaceBagOptionsView.swift
//  Protocol
//
//  Created by lemo on 2018/5/17.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

protocol FaceBagOptionsViewDelegate {
    func selectedFace(index: Int)//选择表情按钮
    func addFaceAction()//添加表情
    func settingFaceAction()//设置表情
}

class FaceBagOptionsView: BQSXIBView {
    //代理
    var delegate: FaceBagOptionsViewDelegate?
    
    var faceDataSource:Array<String>?
    

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    var selectedBtn: UIButton?
    var selectedBtnBackgroundView: UIView?
    
    func addFaceButton() {
        let width: CGFloat = 25.0
        let btnBackgroundViewWidth = BQSScreenWidth / 9.0
        
        let left = (btnBackgroundViewWidth * 7.0 - width * 7.0) / 14.0
        let height = self.frame.height
        let Y = (height - width) / 2.0
        
        
        for num in 0...(faceDataSource?.count)! - 1 {
            let frame: CGRect?
            let lineFrame: CGRect?
            let btn = UIButton()
            if num == 0 {
                frame = CGRect(x: left, y: Y, width: width, height: width)
                lineFrame = CGRect(x: left + 25 + left, y: Y, width: 1, height: width)
            } else {
                frame = CGRect(x: left + (width + 2 * left) * CGFloat(num), y: Y, width: width, height: width)
                lineFrame = CGRect(x: left + (width + 2 * left) * CGFloat(num) + 25 + left, y: Y, width: 1, height: width)
            }
            
            let backgroundView = UIView(frame: CGRect(x: btnBackgroundViewWidth * CGFloat(num), y: 0, width: btnBackgroundViewWidth, height: height))
            backgroundView.backgroundColor = UIColor.white
            backgroundView.tag = 4000 + num
            scrollview.addSubview(backgroundView)
            
            btn.frame = frame!
            btn.tag = 3000 + num
            btn.addTarget(self, action: #selector(selectedAcrion(sender:)), for: .touchUpInside)
            let image = UIImage(named: faceDataSource![num])
            btn.setImage(image, for: .normal)
            scrollview.alwaysBounceVertical = false
            scrollview.addSubview(btn)
            
            if num != faceDataSource!.count - 1 {
                let lineView = UIView(frame: lineFrame!)
                lineView.backgroundColor = UIColor.init(hex: "F5F5F7")
                scrollview.addSubview(lineView)
            }
            
            
        }
        if faceDataSource!.count > 7 {
            scrollview.contentSize = CGSize(width: BQSScreenWidth / 9.0 * CGFloat(faceDataSource!.count), height: 0)
        }
        scrollview.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func addAction(_ sender: Any) {
        delegate?.addFaceAction()
    }
    @IBAction func settingAction(_ sender: Any) {
        delegate?.settingFaceAction()
    }
    
    @objc func selectedAcrion(sender: UIButton) {
//        print("选择表情:\(sender.tag - 3000)")
        if selectedBtn != nil {
            selectedBtnBackgroundView?.backgroundColor = UIColor.white
        }
        selectedBtn = sender
        let back = viewWithTag(sender.tag + 1000)
        back?.backgroundColor = UIColor.init(hex: "F5F5F7")
        selectedBtnBackgroundView = back
        
        delegate?.selectedFace(index: sender.tag + 1000 - 4000)
        
    }
}
