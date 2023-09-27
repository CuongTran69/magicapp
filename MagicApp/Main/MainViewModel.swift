//
//  MainViewModel.swift
//  MagicApp
//
//  Created by Cường Trần on 18/09/2023.
//

import SwiftUI

class MainViewModel: ObservableObject {
    var onboardingVM = OnboardingViewModel()
    
    @AppStorage("user_signed_in") var currentUserSignedIn : Bool = false
    
    @Published var isPresentOptionSheet = false
}
