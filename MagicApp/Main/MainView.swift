//
//  MainView.swift
//  MagicApp
//
//  Created by Cường Trần on 17/08/2023.
//

import SwiftUI

struct MainTabbarView: View {
    @StateObject var mainViewVM = MainViewModel()
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            if mainViewVM.currentUserSignedIn {
                TabView {
                    MainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .badge("News")
                    
                    PersonalView()
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Setting")
                        }
                }
                .tint(.indigo)
            } else {
                OnBoardingView()
            }
        }
        .environmentObject(mainViewVM)
    }
}

//MARK: - MainView
struct MainView: View {
    @EnvironmentObject var mainViewVM: MainViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                RadientBackgroundView
                .ignoresSafeArea()
                .navigationTitle("Homes")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: { 
                    
                }, label: { 
                    Image(systemName: "bell.badge")
                        .foregroundColor(.black)
                        .font(.system(size: normalFontSize))
                }),
                                    trailing: Button(action: { 
                    
                }, label: { 
                    Image(systemName: "info.circle")
                        .foregroundColor(.black)
                        .font(.system(size: normalFontSize))
                }))
            }
            
            
            Text("Sắp rồi!!! Chỉ còn...")
            Spacer()
        }
    }
}

//MARK: - PersonalView
struct PersonalView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadientBackgroundView
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { 
                    HStack {
                        Text("hii")
                            .font(.system(.title, weight: .medium))
                        Text("\(mainVM.onboardingVM.currentUserName ?? "Empty")")
                            .font(.system(.title, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .onTapGesture {
                        mainVM.isPresentOptionSheet.toggle()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .sheet(isPresented: $mainVM.isPresentOptionSheet) {
            ZStack {
                Color.black.opacity(0.8).ignoresSafeArea()
                    .presentationDetents([.fraction(0.3)])
                VStack {
                    
                    Capsule()
                        .frame(width: 50, height: 6)
                        .foregroundColor(.gray)
                        .padding(.vertical)
                    Spacer()
                    
                    Text("Log out")
                        .foregroundColor(.red)
                        .onTapGesture {
                            mainVM.onboardingVM.logout()
                        }
                }
            }
        }
    }
}

//MARK: - MainView_Previews
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}

extension String {
    public var gk2TextName: String {
        if self != "" {
            let separateName = self.components(separatedBy: " ")
            if separateName.count > 1 {
                if let firstChar = separateName.first?.first, let lastChar = separateName.last?.first {
                    return String(firstChar).uppercased() + String(lastChar).uppercased()
                }
            } else {
                if let firstChar = self.first {
                    let pattern = "[0-9]+\\*\\*\\*[0-9]+"
                    let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
                    if predicate.evaluate(with: self) || self.gkValidPhoneNumber() {
                        return String(self.suffix(2))
                    } else {
                        return String(firstChar).uppercased()
                    }
                }
            }
        }
        return "--"
    }
    
    public func gkValidPhoneNumber() -> Bool {
        // GLibrarys/ActiveLabel/RegexParser.swift
        let regexs: [String] = [
            // Đầu số (null|0|+84|84) + (69) + 6 số
            "\\b(0{0,1}|\\+84|84)(69)[0-9]{6}\\b",
            // Đầu số (null|0|+84|84) + (3|5|6|7|8|9) + 8 số
            "\\b(0{0,1}|\\+84|84)(3|5|6|7|8|9)[0-9]{8}\\b",
            // Đầu số (null|0|+84|84) + (2) + 9 số
            "\\b(0{0,1}|\\+84|84)(2)[0-9]{9}\\b",
        ]
        
        for regex in regexs {
            if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self) {
                return true
            }
        }
        return false
    }
}
