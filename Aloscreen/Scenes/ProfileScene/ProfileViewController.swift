//
//  ProfileViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftIcons

protocol ProfileDisplayLogic: class {
    func displaySomething(viewModel: Profile.Something.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    
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
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }


    // MARK: View lifecycle
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameValueLabel: UILabel!
    @IBOutlet weak var phoneValueLabel: UILabel!
    @IBOutlet weak var genderValueLabel: UILabel!
    @IBOutlet weak var LogoutButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        doSomething()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getCurrentUserData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileStyle()
    }
    
    @IBAction func LogoutTapped(_ sender: Any) {
        let confirm = UIAlertController(title: "Ouch", message: "Are you sure want to logout? Make sure you comeback again, okay?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .destructive, handler: nil)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {
            _ in
            guard let username = UserDefaults.standard.string(forKey: "username") else { return }
            UsersOperational.changeLoginStatus(username: username, isLoggedIn: false, isLogout: true)
            let userDefDomain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: userDefDomain)
            UserDefaults.standard.synchronize()
            self.router?.routeToLogin()
        })
        confirm.addAction(yes)
        confirm.addAction(no)
        self.present(confirm, animated: true, completion: nil)
    }
    
    func doSomething() {
        let request = Profile.Something.Request()
        interactor?.doSomething(request: request)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        router?.routeToEdit()
    }
    
    func displaySomething(viewModel: Profile.Something.ViewModel) {
        
    }
    
    func getCurrentUserData() {
        do {
            guard let username = UserDefaults.standard.string(forKey: "username") else { return }
            let allUser = try UsersOperational.readUser()
            let currUser = allUser.filter { $0.username == username }
            if currUser.count != 0 {
                nameLabel.text = currUser[0].name
                emailLabel.text = currUser[0].email
                usernameValueLabel.text = "@" + currUser[0].username
                phoneValueLabel.text = currUser[0].phone
                genderValueLabel.text = currUser[0].gender
            }
        } catch let error {
            print(error)
        }
    }
}

extension ProfileViewController {
    func profileStyle() {
        LogoutButton.layer.cornerRadius = LogoutButton.frame.height/2
        infoView.layer.cornerRadius = 15
        
    }
}
