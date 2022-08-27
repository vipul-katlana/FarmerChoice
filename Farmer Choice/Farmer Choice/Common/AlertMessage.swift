

import Foundation
struct AlertMessage {
    static let yes = "Yes"
    static let no = "No"
    static let cancel = "Cancel"
    static let ok = "Ok"
    
    static let shareApp = NSLocalizedString("Try \(AppInfo.kAppName) App on Appstore:\nhttps://itunes.apple.com/us/app/apple-store/id", comment: "")
    
    static let NetworkError = NSLocalizedString("Server is not responding! Please try after sometime", comment: "")
    static let InternetError = NSLocalizedString("Please check your internet connection and try again",comment:"")
    static let defaultError = NSLocalizedString("Something went wrong, Please try again",comment:"")

    
    static let NetworkTimeOutError = NSLocalizedString("Connection Time Out or Lost.\nPlease try again", comment: "")
    static let otpSend = NSLocalizedString("OTP Send successfully", comment: "")
    static let success = NSLocalizedString("Success", comment: "")
    static let invalidProjectIdentifer = NSLocalizedString("Invalid Project Identifier Format", comment: "")
    
    // Camera and PhotoLibrary Access
    static let cameraAccess  = "To capture photos, allow \(AppInfo.kAppName) to access camera. Please allow it from settings"
    static let photoLibraryAccess  = "To pick photos, allow \(AppInfo.kAppName) to access photo library. Please allow it from settings"
    
    static let loginTitle = NSLocalizedString("Login", comment: "")
    static let requireEmail = NSLocalizedString("Please enter email", comment: "")
    static let invalidEmail = NSLocalizedString("Please enter valid email", comment: "")
    static let requireMobile = NSLocalizedString("Please enter phone number", comment: "")
    static let invalidMobile = NSLocalizedString("Please enter valid phone number", comment: "")
    static let requireUserId = NSLocalizedString("Please enter user id", comment: "")
    static let invalidUserId = NSLocalizedString("Please enter valid user id", comment: "")
    static let requirePassword = NSLocalizedString("Please enter password", comment: "")
    static let requireConfirmPassword = NSLocalizedString("Please enter confirm password", comment: "")
    
    static let requirefirstName = NSLocalizedString("Please enter first name", comment: "")
    static let requirelastName = NSLocalizedString("Please enter last name", comment: "")
    static let signUpTitle = NSLocalizedString("Create Account", comment: "")
    static let invalidPassword = NSLocalizedString("Password length must be between 6 and 15 characters and contain at least one number, one capital letter, one small letter", comment: "")
    static let enterUserName = NSLocalizedString("Please enter user name", comment: "")
    static let minValueUserName = NSLocalizedString("Username must contain at least 5 characters ", comment: "")
    static let maxValueUserName = NSLocalizedString("Username shoudn't conain more than 20 characters", comment: "")
    static let invalidUserName = NSLocalizedString("Invalid username, username should not contain whitespaces or special characters", comment: "")
    
    static let minValueZip = NSLocalizedString("Zip code must contain more than 5 characters", comment: "")
    static let maxValueZip = NSLocalizedString("Zip code shoudn't conain more than 10 characters", comment: "")
    static let invalidZip = NSLocalizedString("Invalid Zip code, zip code should not contain whitespaces, numbers or special characters", comment: "")
    
    static let minValueFirstName = NSLocalizedString("Firstname must contain more than 1 character", comment: "")
    static let maxValueFirstName = NSLocalizedString("Firstname shoudn't conain more than 80 characters", comment: "")
    static let invalidFirstName = NSLocalizedString("Invalid firstname, firstname should not contain numbers or special characters", comment: "")
    static let minValueLastName = NSLocalizedString("Lastname must contain more than 1 character", comment: "")
    static let maxValueLastName = NSLocalizedString("Lastname shoudn't conain more than 80 characters", comment: "")
    static let invalidLastName = NSLocalizedString("Invalid lastname, lastname should not contain numbers or special characters", comment: "")
    static let requiredateOfBirth = NSLocalizedString("Please enter date of birth", comment: "")
    static let passwordConfirmPassword = NSLocalizedString("Password and confirm password must be same", comment: "")
    static let requirestreetAddress = NSLocalizedString("Please select address", comment: "")
    static let requirecity = NSLocalizedString("Please enter city", comment: "")
    static let requirestate = NSLocalizedString("Please enter state", comment: "")
    static let requirezip = NSLocalizedString("Please enter zip code", comment: "")
    static let acceptTermsCondition = NSLocalizedString("Please agree to our terms & conditions and privacy policy", comment: "")
    static let addProfile = NSLocalizedString("Please add profile picture", comment: "")
    static let backToView = NSLocalizedString("Are you sure you want to discard this registration?", comment: "")
    
    
    static let ForgotPasswordTitle = NSLocalizedString("Forgot Password", comment: "")
    
    
    static let otpVerificationPasswordtitle = NSLocalizedString("Verification Code", comment: "")
    static let optNotMatch = NSLocalizedString("Please enter valid otp", comment: "")
    static let verificationNumber = NSLocalizedString("Please type the verification code sent to \n+1 ", comment: "")
    static let timeOut = NSLocalizedString("Time out send again otp", comment: "")
    
    
    //Setting
    static let SettingTitle = NSLocalizedString("Settings", comment: "")
    static let logOutAlert = "Are you sure you want to logout?"
    static let deleteAccountAlert = "Are you sure you want to delete account?"
    
    
    // Change Password
    static let changePasswordTitle = NSLocalizedString("Change Password", comment: "")
    static let requireOldPassword = NSLocalizedString("Please enter old password", comment: "")
    static let requireNewPassword = NSLocalizedString("Please enter new password", comment: "")
    static let invalidNewPassword = NSLocalizedString("New password length must be between 6 and 15 characters and contain at least one number, one capital letter, one small letter", comment: "")
    static let newConfirmPassword = NSLocalizedString("New password and confirm password must be same", comment: "")
    

    
}
