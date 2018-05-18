//
//  CircleCollectionViewCell.swift
//  Protocol
//
//  Created by lemo on 2018/5/17.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class CircleCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    func setModel(model: CircleModel) {
        imageView.image = UIImage(named: model.imageName!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
