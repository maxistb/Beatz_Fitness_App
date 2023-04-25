//
//  Login.swift
//  Beatz Fitness
//
//  Created by Maximillian Stabe on 23.04.23.
//

import Foundation
import LocalAuthentication

enum BiometricType {
    
    case touch
    case face
    case none
    
    var getText: String {
        switch self {
            case .face:
                return "FaceID"
            case .touch:
                return "TouchID"
            default:
                return ""
        }
    }
    
    var getIconName: String {
        switch self {
            case .face:
                return "faceid"
            case .touch:
                return "touchid"
            default:
                return ""
        }
    }
}

class BiometricAuthentication {
    
    private let authenticationContext = LAContext()
    
    func tryBiometricLogin() -> Bool {
        var error: NSError?
        
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return false
        }
        let semaphore = DispatchSemaphore(value: 0)
        let reason = "\(getBiometricType().getText) authentication"
        var correct = false
        authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            if isAuthorized {
                correct = isAuthorized
                semaphore.signal()
            }
        }
        _ = semaphore.wait(timeout: .distantFuture)
        return correct
    }
    
    func getBiometricType() -> BiometricType{
        _ = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        
        switch authenticationContext.biometryType {
            case .faceID:
                return .face
            case .touchID:
                return .touch
            default:
                return .none
        }
    }
}
