//
//  Validator.swift
//  Telegram
//
//  Created by user on 06.03.2021.
//

import Foundation

class Validator {
    
    static func validatePassword(_ candidate: String?) -> Bool {
        guard let candidate = candidate else { return false }
//        let passwordRegex = NSPredicate(format: "SELF MATCHES %@ ","^(?=.*[A-ZА-Я\\u0401\\u0406\\u04BA\\u04B0\\u04AE\\u04E8\\u04A2\\u049A\\u0492\\u04D8])(?=.*[a-zа-я])(?=.*\\d)[A-ZА-Яa-zа-я\\u0401\\u0451\\u0406\\u0456\\u04BA\\u04BB\\u04B0\\u04B1\\u04AE\\u04AF\\u04E8\\u04E9\\u04A2\\u04A3\\u049A\\u049B\\u0492\\u0493\\u04D8\\u04D9\\d]{5,40}$")
        return candidate.count > 0
    }
    
    static func validatePhoneField(_ text: String?) -> Bool {
        guard let text = text else { return false}
        guard !text.isEmpty else { return false}
        return Validator.validatePhone(text)
    }
    
    static private func validatePhone(_ candidate: String?) -> Bool {
        guard let candidate = candidate else { return false }
        let filteredCandidate = candidate.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        let phoneRegex = NSPredicate(format: "SELF MATCHES %@", "^[38]\\d{11}$")
        return phoneRegex.evaluate(with: filteredCandidate)
    }
    
    static func validateEmail(_ candidate: String?) -> Bool {
        guard let candidate = candidate else { return false }
        let emailRegex = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return candidate.count > 0//emailRegex.evaluate(with: candidate)
    }
}
