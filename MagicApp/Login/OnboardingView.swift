//
//  OnboardingView.swift
//  MagicApp
//
//  Created by Cường Trần on 13/09/2023.
//

import SwiftUI

struct OnBoardingView: View {
    @ObservedObject var onboardingVM          = OnboardingViewModel()
    @FocusState var isFocusTextField    : Bool
    
    var body: some View {
        ZStack {
            RadientBackgroundView
            .ignoresSafeArea()
            .overlay { 
                VStack {
                    Spacer()
                    switch onboardingVM.currentscreenState {
                    case 0: welcomeView
                    case 1: userNameView
                    case 2: userAge
                    case 3: userGender
                    default:
                        Text("Tesssst")
                    }
                    
                    Spacer()
                    HStack {
                        if onboardingVM.currentscreenState != 0 {
                            previousButton
                        }
                        loginButton
                    }
                    .padding(10)
                }
            }
            
        }
    }
}

//MARK: - Component
extension OnBoardingView {
    //MARK: - loginButton
    var loginButton: some View {
        Text(onboardingVM.nameLoginButton())
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .onTapGesture {
                onboardingVM.onNextScreen()
            }
    }
    
    //MARK: - previousButton
    var previousButton: some View {
        Image(systemName: "arrowshape.backward.fill")
            .font(.headline)
            .fontWeight(.bold)
            .frame(width: 70, height: 48)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .onTapGesture {
                onboardingVM.onPreviousScreen()
            }
    }
    
    //MARK: - welcomeView
    var welcomeView: some View {
        VStack {
            Spacer()
            Text("Magic App")
                .frame(width: width)
                .font(.custom("Montserrat-ExtraBold", size: 30))
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            Image(systemName: "shared.with.you")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.black.opacity(0.8))
            
            Text("Everything")
                .foregroundColor(.white)
                .font(.title3)
                .bold()
                .italic()
                .padding()
            Spacer()
        }
    }
    
    //MARK: - userNameView
    var userNameView: some View {
        VStack {
            HStack(spacing: -5) {
                Text("Your name is")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.horizontal)
                Text("\(onboardingVM.userName.isEmpty ? "..." : "\(onboardingVM.userName)") ?")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
            }
            
            TextField("Type your name", text: $onboardingVM.userName)
                .focused($isFocusTextField)
                .padding(10)
                .frame(width: width - 20, height: 50)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .onChange(of: onboardingVM.userName) { text in
                    onboardingVM.checkHiddenErrorLabel(isShow: text.count < 3)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isFocusTextField = true
                    }
                }
            if onboardingVM.showErrorLabel {
                Text("Your name at least 3 character")
                    .italic()
                    .foregroundColor(.red)
            }
        }
    }
    
    //MARK: - userAge
    var userAge: some View {
        VStack {
            HStack {
                Text("Your age is")
                    .font(.system(size: 30, weight: .semibold))
                
                Picker("", selection: $onboardingVM.userAge) { 
                    ForEach(onboardingVM.rangeAge, id: \.self) {
                        Text("\($0)")
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .frame(width: 70, height: 100)
                .pickerStyle(.wheel)
                .padding(-5)
                Spacer()
            }
        }
        .padding()
    }
    
    //MARK: - userGender
    var userGender: some View {
        VStack {
            HStack {
                Text("Your gender is")
                    .font(.system(size: 30, weight: .semibold))
                
                Picker("", selection: $onboardingVM.userGender) { 
                    ForEach(Gender.allCases, id: \.rawValue) {
                        Text("\($0.rawValue)")
                            .font(.system(size: 30, weight: .bold))
                    }
                }
                .frame(width: 150)
                .pickerStyle(.wheel)
                .padding(-5)
                Spacer()
            }
        }
        .padding()
    }
}

//MARK: - Func
extension OnBoardingView {
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
