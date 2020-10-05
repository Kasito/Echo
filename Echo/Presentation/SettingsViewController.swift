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
                    let alertController = UIAlertController.create(with: "Error", message: errors)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
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
}
