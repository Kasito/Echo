//
//  InfoViewModel.swift
//  Echo
//
//  Created by Kasito on 23.09.2020.
//

import UIKit

protocol InfoViewModelProtocol {
    
    var numberOfComponents: Int { get }
    var numberOfItems: Int? { get }
    var headerText: String { get }
    var heightForHeader: CGFloat { get }
    var locale: String? { get set }
    var updateHandler: VoidBlock? { get set }
    func setupCell(cell: InfoCell, at indexPath: IndexPath)
    func getText(completion: @escaping (String?) -> Void)
}

class InfoViewModel: InfoViewModelProtocol {
    
    var updateHandler: VoidBlock?
    
    var apiClient: APIClientProtocol?
    
    var text: String? {
        didSet {
            self.updateHandler?()
        }
    }
    
    var histogram: [Character:Int]? {
        guard let text = text else { return [:] }
        return text.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
    
    var numberOfComponents: Int {
        return 1
    }
    
    var numberOfItems: Int? {
        return histogram?.count
    }
    
    var headerText: String {
        return "Count occurrence of each character in the text"
    }
    
    var heightForHeader: CGFloat {
        return 50
    }
    
    var locale: String? 
    
    var token: String? {
        return KeychainService.load(serviceKey: AccessToken.token)
    }
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getText(completion: @escaping (String?) -> Void) {
        apiClient?.getText(token: token, locale: locale) { (object, error) -> (Void) in
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
                self.text = object?.data
                completion(nil)
            }
        }
    }
    
    func setupCell(cell: InfoCell, at indexPath: IndexPath) {
        guard let histogram = histogram else { return }
        let keys = Array(histogram.keys).sorted()
        
        let currentKey = keys[indexPath.row]
        let currentvalue = histogram[currentKey]
        
        cell.chrLabel.text = String(currentKey)
        cell.countLabel.text = String(currentvalue ?? 0)
    }
}
