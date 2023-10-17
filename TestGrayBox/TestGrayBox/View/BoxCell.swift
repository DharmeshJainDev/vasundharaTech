//
//  BoxCell.swift
//  TestGrayBox
//
//  Created by Dharmesh Kochar on 16/10/23.
//

import UIKit

class BoxCell: UICollectionViewCell {

    @IBOutlet weak var boxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxBtn.layer.borderWidth = 1
        boxBtn.layer.borderColor = UIColor.black.cgColor
    }

}
