
import Foundation
import UIKit

class ValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}


enum ValidatorType {
    case email
    case phone
    case password(message: String)
    case username
    case requiredField(message: String)
    case confirmpassword(password: String,reqMessage: String, equalMessage: String )
}

enum VaildatorFactory {
    
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .phone: return PhoneValidator()
        case .password (let message): return PasswordValidator(message)
        case .username: return UserNameValidator()
        case .requiredField(let message): return RequiredFieldValidator(message)
        case .confirmpassword(let password,let message, let equalMessage): return ConfirmPasswordCheck(password,message, equalMessage)
        }
    }
}


class PhoneValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requireMobile)}
        guard (value.count > 0 && value.count == 10)  else {throw ValidationError(AlertMessage.invalidMobile)}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let message: String
    
    init(_ field: String) {
        message = field
    }
    
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError(message)
        }
        return value
    }
}


struct UserNameValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        
        guard value.count != 0 else {
            throw ValidationError(AlertMessage.enterUserName)
        }
        
        guard ((value.count >= 5) && !(value.count == 0)) else {
            throw ValidationError(AlertMessage.minValueUserName)
        }
        guard value.count < 20 else {
            throw ValidationError(AlertMessage.maxValueUserName)
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z0-9_ ]*$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(AlertMessage.invalidUserName)
            }
        } catch {
            throw ValidationError(AlertMessage.invalidUserName)
        }
        return value
    }
}


struct PasswordValidator: ValidatorConvertible {
    
    private let message: String
    init(_ field: String) {
        message = field
    }
    
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(AlertMessage.requirePassword)}
        guard value.count >= 6 && value.count < 16 else { throw ValidationError(message) }
        
        do {
            if !isPasswordValidated(value){
                throw ValidationError(message)
            }
            
        } catch {
            throw ValidationError(message)
        }
        return value
    }
    
    func isPasswordValidated(_ password: String) -> Bool {
        var lowerCaseLetter: Bool = false
        var upperCaseLetter: Bool = false
        var digit: Bool = false
        for char in password.unicodeScalars {
            if !lowerCaseLetter {
                lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
            }
            if !upperCaseLetter {
                upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
            }
            if !digit {
                digit = CharacterSet.decimalDigits.contains(char)
            }
            
        }
        if  (digit && lowerCaseLetter && upperCaseLetter) {
            return true
        }
        else {
            return false
        }
        
    }
    
}

struct EmailValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError(AlertMessage.requireEmail)}
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(AlertMessage.invalidEmail)
            }
        } catch {
            throw ValidationError(AlertMessage.invalidEmail)
        }
        return value
    }
}


struct ConfirmPasswordCheck: ValidatorConvertible {
    private let passwordText: String
    private let reqMessage: String
    private let eqMessage: String
    init(_ field: String, _ requiredMessage: String, _ equalMessage: String) {
        passwordText = field
        reqMessage = requiredMessage
        eqMessage = equalMessage
    }
    
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError(reqMessage)}
        
        guard value == passwordText else {
            throw ValidationError(eqMessage)
        }
        return value
    }
}
