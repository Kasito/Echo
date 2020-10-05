//
//  Rest.swift
//  Echo
//
//  Created by Kasito on 21.09.2020.
//

import Foundation

protocol APIClientProtocol {
    
    func register(body: [String: String]?, completion: @escaping ResponseResult<User>)
    func login(body: [String: String]?, completion: @escaping ResponseResult<User>)
    func logout(completion: @escaping ResponseResult<String>)
    func getText(token: String?, locale: String? ,completion: @escaping ResponseResult<String>)
}

class APIClient: APIClientProtocol {
    
    let baseURL = "http://apiecho.cf"
    let signUp = "/api/signup/"
    let login = "/api/login/"
    let logout = "/api/logout/"
    let getText = "/api/get/text/"
    
    let localeParam = "locale"
    let authorization = "Authorization"
    let bearer = "Bearer "
    
    private func baseCall<T: Codable> (url: String, httpMethod: HTTPMethod, body: [String: String]?, token: String? = nil, query: [URLQueryItem]? = nil, completion: @escaping ResponseResult<T>) {
        
        guard let URL = URL(string: baseURL + url) else { return }
        
        var urlComponets = URLComponents(url: URL, resolvingAgainstBaseURL: true)
        
        if let query = query, query.count > 0 {
            urlComponets?.queryItems = query
        }
        
        guard let requestURL = urlComponets?.url else { return }
        
        var request = URLRequest(url: requestURL)
        
        if let body = body {
            request.httpBody = body.percentEncoded()
        }
        
        if let token = token {
            request.setValue("\(bearer) \(token)", forHTTPHeaderField: authorization)
        }
        
        request.httpMethod = httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            let object = try? JSONDecoder().decode(ResponseObject<T>.self, from: data)
            completion(object, nil)
        }
        task.resume()
    }
    
    func register(body: [String: String]?, completion: @escaping ResponseResult<User>) {
        baseCall(url: signUp, httpMethod: .post, body: body) { (object, error) -> (Void) in
            completion(object, error)
        }
    }
    
    func login(body: [String: String]?, completion: @escaping ResponseResult<User>) {
        baseCall(url: login, httpMethod: .post, body: body) { (object, error) -> (Void) in
            completion(object, error)
        }
    }
    
    func logout(completion: @escaping ResponseResult<String>) {
        baseCall(url: logout, httpMethod: .post, body: nil) { (object, error) -> (Void) in
            completion(object, error)
        }
    }
    
    func getText(token: String?, locale: String? ,completion: @escaping ResponseResult<String>) {
        let query = [URLQueryItem(name: localeParam, value: locale)]
        
        baseCall(url: getText, httpMethod: .get, body: nil, token: token, query: query) { (object, error) -> (Void) in
            completion(object, error)
        }
    }
}
