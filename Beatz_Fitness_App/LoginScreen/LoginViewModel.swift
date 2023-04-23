//
//  Login.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 23.04.23.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper.Key {
    static let keyUsername: KeychainWrapper.Key = "username"
    static let keyPassword: KeychainWrapper.Key = "password"
}

class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    @Published var error = LoginError.none
    private var knownUser = false
    
    private var loginHandler: LoginHandler
    private var biometricAuthentication = BiometricAuthentication()
    
    
    var hasError: Bool {
        get {
            return error != .none
        }
    }
    
    var biometricAuthenticationAvailable: Bool {
        get {
            return knownUser && biometricAuthentication.getBiometricType() != .none
        }
    }
    
    var biometricType: BiometricType {
        get {
            return biometricAuthentication.getBiometricType()
        }
    }
    
    init(loginHandler: LoginHandler) {
        self.loginHandler = loginHandler
        username = KeychainWrapper.standard[.keyUsername] ?? ""
        knownUser = username != ""
    }
    
    func login() -> LoginError {
        error = loginHandler.login(username: username, password: password)
        
        if error == .none {
            KeychainWrapper.standard[.keyUsername] = username
            KeychainWrapper.standard[.keyPassword] = password
        }
        
        return error
    }
    
    func biometricLogin() -> LoginError {
        if biometricAuthentication.tryBiometricLogin() {
            username = KeychainWrapper.standard[.keyUsername] ?? ""
            password = KeychainWrapper.standard[.keyPassword] ?? ""
            return login()
        }
        return LoginError.invalidpassword
    }
}
