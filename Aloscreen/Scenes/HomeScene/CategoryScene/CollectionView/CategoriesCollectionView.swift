//
//  CategoriesCollectionView.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import UIKit
import Kingfisher

class CategoriesCollectioViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var data = [Category]()
    var viewController: HomeCategoryViewController?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCollectionViewCell
        let catData = data[indexPath.section]
        cell.categoryName.text = catData.tags?[0].title.capitalized
        cell.previewImage.kf.setImage(with: URL(string: catData.preview_photos[0].urls.small), placeholder: UIImage(named: "img_blankGrey"), completionHandler: {
            result in
            
            cell.categoryName.hideSkeleton()
            cell.previewImage.hideSkeleton()
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = data[indexPath.section].tags?[0].title
        let destinationSB = UIStoryboard(name: "DetailCategory", bundle: nil)
        let destinationVC = destinationSB.instantiateViewController(withIdentifier: "DetailCategoryStoryboard") as! DetailCategoryViewController
        destinationVC.receivedCategory = selectedCategory ?? "random"
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
