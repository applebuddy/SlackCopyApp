//
//  AuthService.swift
//  SmackPractice
//
//  Created by MinKyeongTae on 25/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import Alamofire
import Foundation

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
        let header = [
            "Content-Type": "application/json; charset=utf-8", // valueType==application/json
        ]

        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "passsword": password,
        ]

        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString(completionHandler: { response in

            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        })
    }
}
