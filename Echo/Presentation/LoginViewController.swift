//
//  ViewController.swift
//  Echo
//
//  Created by Kasito on 21.09.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.text = viewModel?.infoText
        }
    }
    
    @IBOutlet weak var accountLabel: UILabel! {
        didSet {
            accountLabel.text = viewModel?.accountLabelName
        }
    }
    
    @IBOutlet weak var nameDesignableView: DesignableView!
    @IBOutlet weak var confirmPasswordDesignableView: DesignableView!
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var emailAddressTextField: UITextField! {
        didSet {
            emailAddressTextField.delegate = self
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.setTitle(viewModel?.signButtonName, for: .normal)
            signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        }
    }
    
    var viewModel: LoginViewModelProtocol?
    var delegate: CoordinatorDelegate? 
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupSignView() {
        nameDesignableView.isHidden = viewModel?.sign == .login ? true : false
        confirmPasswordDesignableView.isHidden = viewModel?.sign == .login ? true : false
        
        infoLabel.text = viewModel?.infoText
        accountLabel.text = viewModel?.accountLabelName
        signUpButton.setTitle(viewModel?.signButtonName, for: .normal)
    }
    
    func reverseState() {
        let currentState = viewModel?.sign
        viewModel?.sign = currentState == .login ? .register : .login
    }
    
    func clear() {
        viewModel?.body = [:]
        nameTextField.text = nil
        emailAddressTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {_ in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkConfirmPassword() -> Bool {
        if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(message: viewModel?.massage)
            return false
        } else {
            return true
        }
    }
    
    @objc func continueButtonAction(sender: UIButton!) {
        if viewModel?.sign == .register && checkConfirmPassword() {
            viewModel?.register { error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.showAlert(message: error)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.dismissVC(vc: self)
                        self.delegate?.makeTabBar()
                    }
                }
            }
            
        } else if viewModel?.sign == .login {
            viewModel?.login { error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.showAlert(message: error)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.dismissVC(vc: self)
                        self.delegate?.makeTabBar()
                    }
                }
            }
        }
    }
    
    @objc func signUpButtonAction(sender: UIButton!) {
        clear()
        reverseState()
        setupSignView()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        switch textField {
        case nameTextField :
            viewModel?.body?[BodyKey.name] = text
        case emailAddressTextField :
            viewModel?.body?[BodyKey.email] = text
        case passwordTextField :
            viewModel?.body?[BodyKey.password] = text
        default:
            break
        }
    }
}
