//
//  Factory.swift
//  Echo
//
//  Created by Kasito on 04.10.2020.
//

import UIKit

protocol FactoryDelegate {
    func makeLogin()
    func makeTabBar()
}

class Factory: FactoryDelegate {
    
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    var apiClient: APIClient = {
        return APIClient.shared
    }()
    
    private func createVC(withIdStoryboard: String, idVC: String) -> UIViewController {
        let login = UIStoryboard(name: withIdStoryboard, bundle: Bundle.main)
        return login.instantiateViewController(withIdentifier: idVC)
    }
    
    private func createLoginConttroller() -> LoginViewController {
        let vc = createVC(withIdStoryboard: "Main", idVC: "LoginViewController") as! LoginViewController
        let viewModel = LoginViewModel(apiClient: apiClient)
        vc.viewModel = viewModel
        vc.delegate = self
        return vc
    }
    
    private func createTabBarConttroller() -> TabBarController {
        let vc = createVC(withIdStoryboard: "Main", idVC: "TabBarController") as! TabBarController
        let viewModel = TabBarViewModel()
        vc.viewModel = viewModel
        vc.children.forEach { if let vc = $0 as? SettingsViewController {
            vc.viewModel = SettingsViewModel(apiClient: apiClient)
            vc.delegate = self
        } else if let vc = $0 as? InfoViewController {
            vc.viewModel = InfoViewModel(apiClient: apiClient)
        }
        }
        return vc
    }
    
    func makeLogin() {
        guard let window = window else { return }
        window.rootViewController = createLoginConttroller()
        window.makeKeyAndVisible()
    }
    
    func makeTabBar() {
        guard let window = window else { return }
        window.rootViewController = createTabBarConttroller()
        window.makeKeyAndVisible()
    }
}