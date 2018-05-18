//
//  BQSShowFaceCell.swift
//  Protocol
//
//  Created by lemo on 2018/5/16.
//  Copyright © 2018年 wangli. All rights reserved.
//

import UIKit

class BQSShowFaceCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    func setModel(model: BQSShowFaceModel) {
        if let name = model.imageName {
            imageView.image = UIImage(named: name)
        }
        titleLabel.text = model.title;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
