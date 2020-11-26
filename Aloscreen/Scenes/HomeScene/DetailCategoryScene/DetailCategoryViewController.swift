//
//  DetailCategoryViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailCategoryDisplayLogic: class {
    func displayDetailPictures(viewModel: DetailCategory.FetchPictures.ViewModel)
}

class DetailCategoryViewController: UIViewController, DetailCategoryDisplayLogic {
    var interactor: DetailCategoryBusinessLogic?
    var router: (NSObjectProtocol & DetailCategoryRoutingLogic & DetailCategoryDataPassing)?
    
    // MARK:  Object Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = DetailCategoryInteractor()
        let presenter = DetailCategoryPresenter()
        let router = DetailCategoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let scene = segue.identifier {
//            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
//            if let router = router, router.responds(to: selector) {
//                router.perform(selector, with: segue)
//            }
//        }
//    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Category"
        getPhotosByCategory()
        
        DetailCollectionView.dataSource = detailCollectionViewController
        DetailCollectionView.delegate = detailCollectionViewController
        DetailCollectionView.isPagingEnabled = true
        DetailCollectionView.showsHorizontalScrollIndicator = false
        DetailCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    // MARK: Do something
    @IBOutlet weak var SelectedCategoryValue: UILabel!
    @IBOutlet weak var DetailCollectionView: UICollectionView!
    @IBOutlet weak var DetailPageControl: UIPageControl!
    
    var receivedCategory = ""
    
    lazy var detailCollectionViewController: DetailCollectionViewController = {
        let dcv = DetailCollectionViewController()
        return dcv
    }()
    
    func getPhotosByCategory() {
        let randomInt = Int.random(in: 1..<20)
        SelectedCategoryValue.text = receivedCategory.capitalized
        let request = DetailCategory.FetchPictures.Request(page: randomInt, query: receivedCategory)
        interactor?.getDetailPictures(request: request)
    }
    
    func displayDetailPictures(viewModel: DetailCategory.FetchPictures.ViewModel) {
   
        DetailPageControl.numberOfPages = viewModel.show.results.count
        DetailPageControl.currentPage = 0
        detailCollectionViewController.data = viewModel.show
        detailCollectionViewController.pageControl = DetailPageControl
        DetailCollectionView.reloadData()
        
    }
}
