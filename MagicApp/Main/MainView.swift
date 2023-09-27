//
//  ContentView.swift
//  MagicApp
//
//  Created by Cường Trần on 17/08/2023.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem { 
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ListUserView()
                .tabItem { 
                    Image(systemName: "person")
                    Text("Users")
                }
            
        }
        .tint(.orange)
    }
}

struct MainView: View {
    @State private var fullScreen = false
    var body: some View {
        ZStack {
            RadialGradient(gradient: mainBackroundColor,
                           center: .top,
                           startRadius: 5,
                           endRadius: height)
            .ignoresSafeArea()
            VStack {
                NavigationCustom
            }
        }
    }
    
    var NavigationCustom: some View {
        NavigationView {
            Text("")
            .navigationTitle("Homes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: {
                PersonalView()
            }, label: {
                Image(systemName: "bell.badge.fill")
                    .foregroundColor(.black)
                    .font(.system(size: normalFontSize))
            }),
                                trailing: NavigationLink(destination: {
                
            }, label: {
                Image(systemName: "gear")
                    .foregroundColor(.black)
                    .font(.system(size: normalFontSize))
            }))
        }
    }
}

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let displayName: String
    let follower: Int
    let isVerified: Bool
}

struct ListUserView: View {
    @State var isShowAlert = false
    @State var isShowActionSheet = false
    @State var textString = ""
    
    @StateObject var listUserVM: ListUserViewModel = ListUserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listUserVM.listUser) { user in
                    HStack(spacing: 25) {
                        Text(user.displayName.gk2TextName)
                            .overlay { 
                                Circle()
                                    .stroke(lineWidth: 1)
                                .fill(.gray)
                                .frame(width: 40)
                                .padding(-5)
                            }
                        
                        VStack {
                            HStack {
                                Text(user.displayName)
                                    .font(.title2)
                                
                                if user.isVerified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            Text("@\(user.displayName)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("\(user.follower)")
                                .font(.title2)
                            Text("follower")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(5)
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                trailing: ButtonMore
            )
            .actionSheet(isPresented: $isShowActionSheet, content: getActionSheet)
            .alert(isPresented: $isShowAlert, content: getAlert)
        }
        .onAppear {
//            listUserVM.getListUser()
        }
        .onDisappear {
//            listUserVM.resetListUser()
        }
        .navigationBarHidden(true)
    }
    
    
    
    var ButtonMore: some View {
        Button(action: { 
            isShowActionSheet.toggle()
        }, label: { 
            Image(systemName: "ellipsis")
        }).foregroundColor(.black)
    }
    
    func getAlert() -> Alert {
        Alert(title: Text("Add"), 
              message: Text("Do u want to add?"), primaryButton: .cancel(), secondaryButton: .default(Text("Add"), action: { 
            listUserVM.appendNewUser()
        }))
    }
    
    func getActionSheet() -> ActionSheet {
        let editAction: ActionSheet.Button = .destructive(Text("Edit")) { 
            
        }
        let addAction: ActionSheet.Button = .default(Text("Add")) {
            isShowAlert.toggle()
        }
        let cancelAction: ActionSheet.Button = .cancel()
        
        return ActionSheet(title: Text("Actions"),
                    buttons: [editAction, addAction, cancelAction])
    }
}

struct PersonalView: View {
    @Environment (\.presentationMode) var backButton 
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person")
                            .font(.largeTitle)
                        Text("@name")
                            .font(.title)
                    }
                    Text("This is my description")
                }
                .padding(20)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
            }
            .navigationTitle("Personals")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(leading: BackButton)
            .contextMenu { 
                Text("Text")
            }
        }
        .navigationBarHidden(true)
    }
    
    var BackButton: some View {
        Button(action: { 
            backButton.wrappedValue.dismiss()
        }, label: { 
            Image(systemName: "arrow.backward")
                .foregroundColor(.black)
                .fontWeight(.bold)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
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
