//
//  TabBarViewModel.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import Foundation

protocol TabBarViewModelProtocol {
    
    var firstTabTitle: String { get }
    var secondTabTitle: String { get }
}


class TabBarViewModel: TabBarViewModelProtocol {
    
    var firstTabTitle = "Histogram"
    var secondTabTitle = "Settings"
}
