//
//  CategoriesCollectionViewCell.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import UIKit
import SkeletonView

class CategoriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        previewImage.contentMode = .scaleAspectFill
        previewImage.clipsToBounds = true
        previewImage.showGradientSkeleton()
        categoryName.showGradientSkeleton()
    }
    
}
