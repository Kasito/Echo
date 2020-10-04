//
//  SettingsViewModel.swift
//  Echo
//
//  Created by Kasito on 22.09.2020.
//

import Foundation

protocol SettingsViewModelProtocol {
    
    var titleNavBar: String { get }
    var logoutButtonTitle : String { get }
    var successMessage: String { get }
    func logout(completion: @escaping (String?) -> Void)
}

class SettingsViewModel: SettingsViewModelProtocol {
    
    var apiClient: APIClientProtocol?
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func logout(completion: @escaping (String?) -> Void) {
        apiClient?.logout {(object, error) in
            if error != nil {
                completion (error?.localizedDescription)
            }
            else if object?.success == false {
                var error = ""
                object?.errors?.forEach({ errors in
                    error.append(errors.message!)
                })
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    var titleNavBar: String {
        return "Settings"
    }
    
    var logoutButtonTitle: String {
        return "Logout"
    }
    
    var successMessage: String {
        return "Done"
    }
}
