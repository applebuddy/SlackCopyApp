//
//  Constants.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

typealias CompletionHandler = (_ Success: Bool) -> Void
typealias Jonny = String

let name: Jonny = "Jonny"

// MARK: - URL Constants

let BASE_URL = "https://slackcopyapp3.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

// MARK: - Colors

let smackPurplePlaceholder = #colorLiteral(red: 0.5143675086, green: 0.3790132705, blue: 1, alpha: 0.5)

// MARK: - Notification

let NOTIFI_USER_DATA_DID_CHANGE = Notification.Name("notiUserDataChanged")

// MARK: - Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"
let To_AVATAR_PICKER = "toAvatarPicker"

// MARK: - User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// MARK: - Headers

let HEADER = ["Content-Type": "application/json; charset=utf-8"]
