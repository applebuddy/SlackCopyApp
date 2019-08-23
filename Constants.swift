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
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

// MARK: - Colors

let smackPurplePlaceholder = #colorLiteral(red: 0.5143675086, green: 0.3790132705, blue: 1, alpha: 0.5)

// MARK: - Notification

let NOTIFI_USER_DATA_DID_CHANGE = Notification.Name("notiUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")

// MARK: - Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND_TO_CHANNEL = "unwindToChannel"

// MARK: - User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let TO_AVATAR_PICKER = "toAvatarPicker"

// MARK: - Headers

let HEADER = ["Content-Type": "application/json; charset=utf-8"]
var BEARER_HEADER: [String: String] {
    return [
        "Authorization": "Bearer \(AuthService.instance.authToken)",
        "Content-type": "application/json; charset=utf-8",
    ]
}

// MARK: - Cell Identifiers

let avatarCollectionCell = "avatarCollectionViewCell"
let messageTableViewCell = "messageTableViewCell"
