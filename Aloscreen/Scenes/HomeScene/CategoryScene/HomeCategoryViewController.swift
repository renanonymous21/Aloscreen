//
//  HomeCategoryViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftIcons

protocol HomeCategoryDisplayLogic: class {
    func displayCategories(viewModel: HomeCategory.FetchCategory.ViewModel)
}

class HomeCategoryViewController: UIViewController, HomeCategoryDisplayLogic {
    var interactor: HomeCategoryBusinessLogic?
    var router: (NSObjectProtocol & HomeCategoryRoutingLogic & HomeCategoryDataPassing)?
    
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
        let interactor = HomeCategoryInteractor()
        let presenter = HomeCategoryPresenter()
        let router = HomeCategoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        getCategoriesList()
        
        CategoriesCollectionView.dataSource = categoriesCollectionView
        CategoriesCollectionView.delegate = categoriesCollectionView
        
        let refreshImage = UIImage(icon: .linearIcons(.sync), size: CGSize(width: 30, height: 30), textColor: Colors.mainBlue)
        RefreshBarButton.image = refreshImage
    }

    // MARK: Do something
    
    @IBOutlet weak var RefreshBarButton: UIBarButtonItem!
    @IBOutlet weak var CategoriesCollectionView: UICollectionView!
    
    lazy var categoriesCollectionView: CategoriesCollectioViewController = {
        let catCollectionView = CategoriesCollectioViewController()
        return catCollectionView
    }()
    
    func getCategoriesList() {
        
        let randomPage = Int.random(in: 1...10)
        let request = HomeCategory.FetchCategory.Request(page: randomPage)
        interactor?.getCategories(request: request)
    }
    @IBAction func refreshContent(_ sender: Any) {
        getCategoriesList()
    }
    
    func displayCategories(viewModel: HomeCategory.FetchCategory.ViewModel) {
        categoriesCollectionView.data = viewModel.show
        categoriesCollectionView.viewController = self
        CategoriesCollectionView.reloadData()
    }
}
