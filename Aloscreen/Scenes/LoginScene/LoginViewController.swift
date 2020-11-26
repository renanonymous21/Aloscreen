//
//  LoginViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftIcons

protocol LoginDisplayLogic: class {
    func displayLogin(viewModel: Login.FetchLogin.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
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
        
        do {
            print(try UsersOperational.readUser())
        } catch let error {
            print(error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: Do something

    @IBOutlet weak var UsernameTextField: CustomTextField!
    @IBOutlet weak var PasswordTextField: CustomTextField!
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    func fetchLogin(username: String, password: String) {
       
        let request = Login.FetchLogin.Request(username: username, password: password)
        interactor?.fetchLogin(request: request)
    }
    
    @IBAction func SignInTapped(_ sender: Any) {
        guard let username = UsernameTextField.text else { return }
        guard let password = PasswordTextField.text else { return }
        if username != "" && password != "" {
            fetchLogin(username: username, password: password)
        } else {
            let alert = UIAlertController(title: "Whoa!", message: "Sorry mate, you can't continue with empty username and password\n If you don't have one, go register first\n\n It's totally FREE", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        router?.routeToRegistration()
    }
    
    func displayLogin(viewModel: Login.FetchLogin.ViewModel) {
        if viewModel.show.username.isEmpty == false {
            router?.routeToHome()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    func loginStyle() {
        UsernameTextField.delegate = self
        let usernameIcon = UIImage(icon: .fontAwesomeSolid(.at), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        UsernameTextField.leftImage = usernameIcon
        UsernameTextField.leftPadding = 5.0
        UsernameTextField.cornerRadius = UsernameTextField.frame.height/2
        UsernameTextField.tintColor = Colors.mainBlue
        
        PasswordTextField.delegate = self
        let passwordIcon = UIImage(icon: .fontAwesomeSolid(.lock), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        PasswordTextField.leftImage = passwordIcon
        PasswordTextField.leftPadding = 5.0
        PasswordTextField.cornerRadius = PasswordTextField.frame.height/2
        PasswordTextField.tintColor = Colors.mainBlue
        
        SignInButton.layer.cornerRadius = SignInButton.frame.height/2
    }
}
