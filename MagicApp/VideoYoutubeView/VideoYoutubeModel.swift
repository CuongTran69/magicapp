//
//  VideoYoutubeModel.swift
//  MagicApp
//
//  Created by Cường Trần on 10/10/2023.
//

import Foundation

struct VideoYoutubeModel: Identifiable {
    let id: String
    let channelId: String
    let videoId: String
    let titleVideo: String
    let thumbnailURL: URL
    let views: Int
    let avatarChannel: String
    let channelTitle: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? [String: Any],
              let videoId = id["videoId"] as? String,
              let snippet = json["snippet"] as? [String: Any],
              let titleVideo = snippet["title"] as? String,
              let channelId = snippet["channelId"] as? String,
              let titleChannel = snippet["channelTitle"] as? String,
              let thumbnails = snippet["thumbnails"] as? [String: Any],
              let defaultThumbnail = thumbnails["high"] as? [String: Any],
              let thumbnailURLString = defaultThumbnail["url"] as? String,
              let thumbnailURL = URL(string: thumbnailURLString) else {
            return nil
        }
        self.id = videoId
        self.channelId = channelId
        self.videoId = videoId
        self.titleVideo = titleVideo
        self.thumbnailURL = thumbnailURL
        self.views = 200
        self.avatarChannel = ""
        self.channelTitle = titleChannel
    }
}
