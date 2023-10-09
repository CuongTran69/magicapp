//
//  MainView.swift
//  MagicApp
//
//  Created by Cường Trần on 17/08/2023.
//

import SwiftUI

struct MainTabbarView: View {
    @EnvironmentObject var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            if mainVM.currentUserSignedIn {
                TabView {
                    MainView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .badge("News")
                    
                    SettingView()
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
            CountDownTetView()
        }
    }
}

//MARK: - PersonalView
struct SettingView: View {
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
