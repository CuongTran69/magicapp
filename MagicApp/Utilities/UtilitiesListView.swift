//
//  UtilitiesListView.swift
//  MagicApp
//
//  Created by Cường Trần on 14/11/2023.
//

import SwiftUI
import PromiseKit
import Alamofire

struct UtilitiesListView: View {
    @State var listModel = ListUtilitiesModel()
    
    var body: some View {
        List { 
            Section {
                ForEach(listModel.createList()) { list in
                    UtilitiesCell(listModel: list)
                }
            } header: {
                Text("List Favorite")
            }
            
//            .listRowSeparator(.visible)
        }.environment(\.defaultMinListRowHeight, 60)
    }
}

//struct UtilitiesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UtilitiesListView()
//    }
//}

struct UtilitiesCell: View {
    var listModel: ListUtilitiesModel
    @State var textChange = ""
    @State var currency: Int = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(listModel.title)
                    .font(.headline)
                if !listModel.isHiddenSub {
                    TextField("Nhập số tiền", text: $textChange)
                        .keyboardType(.decimalPad)
                    HStack {
                        Image(systemName: "arrow.left.arrow.right")
                        if !textChange.isEmpty, let cur = Double(textChange) {
//                            Text("\((cur * currency)) VNĐ")
                        } else {
                            Text("0 VNĐ")
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            firstly { 
                getCurrency()
            }
            .done { value in
                self.currency = value
            }
            .cauterize()
        }
    }
    
    func getCurrency() -> Promise<Int> {
        let url = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/cnh/vnd.json"
        return Promise { seal in
            AF.request(url, parameters: nil).responseJSON {
                switch $0.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let item = json["vnd"] as? Double {
                        seal.fulfill(Int(item))
                    } else {
                        seal.reject(NetworkError.invalidResponse(message: "Đã có lỗi xảy ra!"))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

struct ListUtilitiesModel: Identifiable, Hashable {
    var id          = UUID().uuidString
    var title       = ""
    var isHiddenSub = false
    var isFavorite  = false
    
    func createList() -> [ListUtilitiesModel] {
        [
            ListUtilitiesModel(title: "Chuyển đổi đồng nhân dân tệ", isHiddenSub: false, isFavorite: true),
            ListUtilitiesModel(title: "Giá vàng hôm nay", isHiddenSub: true, isFavorite: false)
        ]
    }
}
