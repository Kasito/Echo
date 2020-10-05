//
//  UserViewController.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var tapBarItem: UITabBar!
    
    var viewModel: TabBarViewModelProtocol? {
        didSet{
            tapBarItem.items?[0].title = viewModel?.firstTabTitle
            tapBarItem.items?[1].title = viewModel?.secondTabTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


