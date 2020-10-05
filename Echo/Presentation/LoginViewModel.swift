//
//  HomeViewModel.swift
//  Echo
//
//  Created by Kasito on 21.09.2020.
//

import Foundation

protocol LoginViewModelProtocol {
    
    var infoText: String { get }
    var signButtonName: String { get }
    var accountLabelName: String { get }
    var massage: String { get }
    var sign: SignType { get set }
    var body: [String: String]?  { get set }
    func register(completion: @escaping (String?) -> Void)
    func login(completion: @escaping (String?) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    
    var apiClient: APIClientProtocol?
    var sign: SignType = .login
    
    var body: [String: String]? = [BodyKey.email: "forte@gmail.com", BodyKey.password: "forte"]
    
    var infoText: String {
        return sign == .login ? "Welcome back" : "Register"
    }
    
    var signButtonName: String{
        return sign == .login ? "Sign up" : "Sign in"
    }
    
    var accountLabelName: String {
        return sign == .login ? "Don't have an account?" : "Have an account?"
    }
    
    var massage: String {
        return "password don't match"
    }
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func handleResult(object: ResponseObject<User>?, error: Error?, completion: @escaping (String?) -> Void) {
        if error != nil {
            completion (error?.localizedDescription)
        }
        else if object?.success == false {
            var error = ""
            object?.errors?.forEach({ errors in
                error += errors.message! + "\n"
            })
            completion(error)
        } else {
            if let token = object?.data?.access_token {
                KeychainService.save(token, serviceKey: AccessToken.token)
            }
            completion(nil)
        }
    }
    
    func register(completion: @escaping (String?) -> Void) {
        apiClient?.register(body: body) {(object, error) in
            self.handleResult(object: object, error: error, completion: completion)
        }
    }
    
    func login(completion: @escaping (String?) -> Void) {
        apiClient?.login(body: body) {(object, error) in
            self.handleResult(object: object, error: error, completion: completion)
        }
    }
}
