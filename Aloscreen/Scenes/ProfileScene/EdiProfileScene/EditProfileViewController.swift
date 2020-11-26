//
//  EditProfileViewController.swift
//  Aloscreen
//
//  Created by Rendy K.R on 26/11/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditProfileDisplayLogic: class {
    func displaySomething(viewModel: EditProfile.Something.ViewModel)
}

class EditProfileViewController: UIViewController, EditProfileDisplayLogic {
    var interactor: EditProfileBusinessLogic?
    var router: (NSObjectProtocol & EditProfileRoutingLogic & EditProfileDataPassing)?
    
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
        let interactor = EditProfileInteractor()
        let presenter = EditProfilePresenter()
        let router = EditProfileRouter()
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
        self.title = "Edit Profile"
        
        let pickerView = UIPickerView()
        GenderTextField.inputView = pickerView
        pickerView.delegate = self
        doSomething()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        editProfileStyle()
    }

    // MARK: Do something

    @IBOutlet weak var NameTextField: CustomTextField!
    @IBOutlet weak var EmailTextField: CustomTextField!
    @IBOutlet weak var PhoneTextField: CustomTextField!
    @IBOutlet weak var GenderTextField: CustomTextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    let username = UserDefaults.standard.string(forKey: "username") ?? ""
    let genderArr =  ["Male", "Female"]
    
    @IBAction func SaveButtonTapped(_ sender: Any) {
        
        let name = NameTextField.text ?? ""
        let email = EmailTextField.text ?? ""
        let phone = PhoneTextField.text ?? ""
        let gender = GenderTextField.text ?? ""
        
        if username.isEmpty == false {
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure want to save this data?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default, handler: {
                _ in
                UsersOperational.updateUser(username: self.username, name: name, email: email, phone: phone, gender: gender)
            })
            let no = UIAlertAction(title: "No", style: .destructive, handler: nil)
            alert.addAction(yes)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func doSomething() {
        do {
            let users = try UsersOperational.readUser()
            let filter = users.filter { $0.username == username }
            if filter.count > 0 {
                NameTextField.text = filter[0].name
                EmailTextField.text = filter[0].email
                PhoneTextField.text = filter[0].phone
                GenderTextField.text = filter[0].gender
            }
        } catch let error {
            print(error)
        }
        
        
        let request = EditProfile.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: EditProfile.Something.ViewModel) {
        
    }
}

extension EditProfileViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func editProfileStyle() {
        NameTextField.delegate = self
        let nameIcon = UIImage(icon: .fontAwesomeSolid(.user), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        NameTextField.leftImage = nameIcon
        NameTextField.leftPadding = 5.0
        NameTextField.cornerRadius = NameTextField.frame.height/2
        
        EmailTextField.delegate = self
        let emailIcon = UIImage(icon: .fontAwesomeSolid(.at), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        EmailTextField.leftImage = emailIcon
        EmailTextField.leftPadding = 5.0
        EmailTextField.cornerRadius = EmailTextField.frame.height/2
        
        PhoneTextField.delegate = self
        let phoneIcon = UIImage(icon: .fontAwesomeSolid(.phone), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        PhoneTextField.leftImage = phoneIcon
        PhoneTextField.leftPadding = 5.0
        PhoneTextField.cornerRadius = PhoneTextField.frame.height/2
        
        GenderTextField.delegate = self
        let genderIcon = UIImage(icon: .fontAwesomeSolid(.transgender), size: CGSize(width: 35, height: 35), textColor: .darkGray)
        GenderTextField.leftImage = genderIcon
        GenderTextField.leftPadding = 5.0
        GenderTextField.cornerRadius = PhoneTextField.frame.height/2
        
        SaveButton.layer.cornerRadius = SaveButton.frame.height/2
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        GenderTextField.text = genderArr[row]
        self.view.endEditing(true)
    }
    
    
}
