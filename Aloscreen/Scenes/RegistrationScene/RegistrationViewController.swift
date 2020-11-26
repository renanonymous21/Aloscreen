//
//  RegistrationViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 25/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol RegistrationDisplayLogic: class {
    func displayAfterRegister(viewModel: Registration.Model.ViewModel)
}

class RegistrationViewController: UIViewController, RegistrationDisplayLogic {
    var interactor: RegistrationBusinessLogic?
    var router: (NSObjectProtocol & RegistrationRoutingLogic & RegistrationDataPassing)?
    
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
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
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
        self.title = "Register User"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        registrationStyle()
    }

    // MARK: Do something

    @IBOutlet weak var NameTextField: CustomTextField!
    @IBOutlet weak var UsernameTextField: CustomTextField!
    @IBOutlet weak var PasswordTextField: CustomTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    func registerRequest() {
        let name = NameTextField.text ?? ""
        let username = UsernameTextField.text ?? ""
        let password = PasswordTextField.text ?? ""
        
        let valFields = validations(name: name, username: username, password: password)
        
        if valFields == true {
            let request = Registration.Model.Request(name: name, username: username, password: password)
            interactor?.registerNewUser(request: request)
        }
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        registerRequest()
    }
    
    func displayAfterRegister(viewModel: Registration.Model.ViewModel) {
        if viewModel.displayData.username.isEmpty == false {
            router?.routeToHome()
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    func validations(name: String, username: String, password: String) -> Bool {
        if name.isEmpty || username.isEmpty || password.isEmpty {
            alert.showMessage(title: "Oops!", msg: "All fields must be filled!")
            return false
        } else {
            return true
        }
    }
    
    func registrationStyle() {
        NameTextField.delegate = self
        let nameIcon = UIImage(icon: .fontAwesomeSolid(.user), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        NameTextField.leftImage = nameIcon
        NameTextField.leftPadding = 5.0
        NameTextField.cornerRadius = NameTextField.frame.height/2
        
        UsernameTextField.delegate = self
        let usernameIcon = UIImage(icon: .fontAwesomeSolid(.at), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        UsernameTextField.leftImage = usernameIcon
        UsernameTextField.leftPadding = 5.0
        UsernameTextField.cornerRadius = UsernameTextField.frame.height/2
        
        PasswordTextField.delegate = self
        let passwordIcon = UIImage(icon: .fontAwesomeSolid(.lock), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        PasswordTextField.leftImage = passwordIcon
        PasswordTextField.leftPadding = 5.0
        PasswordTextField.cornerRadius = PasswordTextField.frame.height/2
        
        registerButton.layer.cornerRadius = registerButton.frame.height/2
    }
}
