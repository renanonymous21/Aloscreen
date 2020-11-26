//
//  DetailCollectionView.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//

import UIKit
import Kingfisher

class DetailCollectionViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var data: DetailData?
    var pageControl: UIPageControl?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let imgData = data {
            return imgData.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DetailCollectionViewCell
        
        cell.image.kf.setImage(with: URL(string: (data?.results[indexPath.section].urls.small)!), placeholder: UIImage(named: "img_blankGrey"), completionHandler: {
            result in
            
            cell.image.hideSkeleton()
            cell.setNeedsLayout()
            
        })
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
    }
    
}
