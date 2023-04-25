////  LoginHandler.swift
//  LoginScreen
//
//
//  Login.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 23.04.23.
//

import Foundation

enum LoginError {
    case none
    case invalidpassword
    case ba
    
    var description: String {
        get {
            switch self {
            case .none: return ""
            case .invalidpassword: return "Falsches Passwort"
            case .ba: return "Problem mit FaceID"
            }
        }
    }
}

protocol LoginHandler {
    func login(username: String, password: String) -> LoginError
}

class LoginHanlderMock: LoginHandler {
    func login(username: String, password: String) -> LoginError {
        if username == "Maximillian" && password == "Admin" {
            return .none
        } else {
            return .invalidpassword
        }
    }
}
