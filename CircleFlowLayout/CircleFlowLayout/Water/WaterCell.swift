//
//  WaterCell.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class WaterCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setModel(model:WaterModel) {
        imageView.image = UIImage(named: model.imageName!)
        titleLabel.text = model.imageTitle
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
