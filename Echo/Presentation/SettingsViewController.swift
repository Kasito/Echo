//
//  SettingsViewController.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var titleNavBar: UINavigationItem! {
        didSet {
            titleNavBar.title = viewModel?.titleNavBar
        }
    }
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.setTitle(viewModel?.logoutButtonTitle, for: .normal)
        }
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        viewModel?.logout { errors in
            if errors != nil {
                DispatchQueue.main.async {
                    self.showAlert(message: errors)
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.dismissVC(vc: self)
                    self.delegate?.makeLogin()
                }
            }
        }
    }
    
    var viewModel: SettingsViewModelProtocol?
    var delegate: CoordinatorDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {_ in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
