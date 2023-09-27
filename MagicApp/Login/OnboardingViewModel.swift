//
//  OnboardingViewModel.swift
//  MagicApp
//
//  Created by Cường Trần on 13/09/2023.
//

import SwiftUI

enum ScreenOnboarding: Int, CaseIterable {
    case Welcome
    case UserName
    case Age
    case Gender
}

enum Gender: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case male
    case female
}

class OnboardingViewModel: ObservableObject {
    var rangeAge = Array(13...99)
    
    @Published var currentscreenState   : Int       = 0
    @Published var userName             : String    = ""
    @Published var userAge              : Int       = 18
    @Published var userGender           : String    = ""
    @Published var showErrorLabel       : Bool      = false
    @Published var delayToDisplay       : Bool      = false
    
    @AppStorage("user_name")        var currentUserName     : String?
    @AppStorage("user_age")         var currentUserAge      : Int?
    @AppStorage("user_gender")      var currentUserGender   : String?
    @AppStorage("user_signed_in")   var currentUserSignedIn : Bool = false
    
    
    func nameLoginButton() -> String {
        switch currentscreenState {
        case 0  : return "Get Start"
        case 3  : return "Sign In"
        default : return "Next"
        }
    }
    
    func onNextScreen() {
        guard currentscreenState < ScreenOnboarding.allCases.count else { return }
        switch currentscreenState {
        case 1:
            if userName.count < 3 {
                checkHiddenErrorLabel(isShow: true)
                return
            }
        case 3:
            signIn()
        default:
            break
        }
        withAnimation() { 
            currentscreenState += 1
        }
    }
    
    func onPreviousScreen() {
        guard currentscreenState > 0 else { return }
        withAnimation(.spring()) { 
            currentscreenState -= 1
        }
    }
    
    func checkHiddenErrorLabel(isShow: Bool) {
        showErrorLabel = isShow
    }
    
    func signIn() {
        currentUserName = userName
        currentUserAge = userAge
        currentUserGender = userGender
        currentUserSignedIn = true
    }
    
    func logout() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        currentUserSignedIn = false
    }
} 
