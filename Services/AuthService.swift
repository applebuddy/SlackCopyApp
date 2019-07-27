//
//  AuthService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 25/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    let defaults = UserDefaults.standard

    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }

    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }

    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }

    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) { // 이메일과 패스워드를 받아 유저를 등록하는 메서드
        let lowerCaseEmail = email.lowercased()
        print("body : \(lowerCaseEmail)")
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password,
        ]

        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString(completionHandler: { response in

            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "passsword": password,
        ]
        
        // POST 요청 후 정 공 시 데이터 처리를 한다.
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String, Any> {
                    // as? String : as가 메모리 역할로 보고, 타입 캐스팅이 되는지 확인하는 모양새
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
                    
                    // Using SwiftyJSON
                guard let data = response.data, let json = try? JSON(data: data) else {
                    completion(false)
                    return
                    
                }
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
