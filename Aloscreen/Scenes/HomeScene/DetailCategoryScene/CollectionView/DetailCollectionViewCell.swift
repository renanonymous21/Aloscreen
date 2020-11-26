//
//  DetailCollectionViewCell.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15.0
        image.showGradientSkeleton()
    }
}
