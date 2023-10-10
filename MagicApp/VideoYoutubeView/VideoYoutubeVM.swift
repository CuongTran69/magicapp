//
//  VideoYoutubeVM.swift
//  MagicApp
//
//  Created by Cường Trần on 10/10/2023.
//

import SwiftUI
import PromiseKit

class VideoYoutubeVM: ObservableObject {
    @Published var videos: [VideoYoutubeModel] = []
    @Published var avatarChannel: String = ""
    
    func fetchData() {
        firstly {
            NetworkManager.shared.fetchDataFromYouTube(with: "pewdiepie")
        }
        .then { [weak self] videos -> Promise<String> in
            self?.videos = videos
            return NetworkManager.shared.fetchAvatarChannel(channelId: videos.first?.channelId ?? "")
        }
        .done { [weak self] avatar in
            self?.avatarChannel = avatar
        }.catch { error in
            print("Error: \(error)")
        }
    }
}
