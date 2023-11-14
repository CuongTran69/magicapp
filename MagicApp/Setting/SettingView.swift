////
////  SettingView.swift
////  MagicApp
////
////  Created by Cường Trần on 25/10/2023.
////
//
//import SwiftUI
//
//struct SettingVieww: View {
//    @EnvironmentObject var mainVM: MainViewModel
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                RadientBackgroundView
//                    .ignoresSafeArea()
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) { 
//                    HStack {
//                        Text("hii")
//                            .font(.system(.title, weight: .medium))
//                        Text("\(mainVM.onboardingVM.currentUserName ?? "Empty")")
//                            .font(.system(.title, weight: .bold))
//                        Image(systemName: "chevron.down")
//                            .font(.caption)
//                    }
//                    .onTapGesture {
//                        mainVM.isPresentOptionSheet.toggle()
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//            }
//        }
//        .sheet(isPresented: $mainVM.isPresentOptionSheet) {
//            ZStack {
//                Color.black.opacity(0.8).ignoresSafeArea()
//                    .presentationDetents([.fraction(0.3)])
//                VStack {
//                    
//                    Capsule()
//                        .frame(width: 50, height: 6)
//                        .foregroundColor(.gray)
//                        .padding(.vertical)
//                    Spacer()
//                    
//                    Text("Log out")
//                        .foregroundColor(.red)
//                        .onTapGesture {
//                            mainVM.onboardingVM.logout()
//                        }
//                }
//            }
//        }
//    }
//}
//
//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
