//
//  NetworkManager.swift
//  MagicApp
//
//  Created by Cường Trần on 09/10/2023.
//

import Alamofire
import PromiseKit

enum NetworkError: Error {
    case invalidResponse
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    let BaseURL = "https://www.googleapis.com/youtube/v3"
    let ApiKey  = ""
    let limit   = 10
    
    func fetchDataFromYouTube(with input: String) -> Promise<[VideoYoutubeModel]> {
        let url = "\(BaseURL)/search"
        let parameters: [String: Any] = [
            "part": "snippet",
            "maxResults": limit,
            "q": input,
            "key": ApiKey
        ]
        
        return Promise { seal in
            AF.request(url, parameters: parameters).responseJSON {
                switch $0.result {
                case .success(let value):
                    // Parse the response and map it to an array of Video objects
                    if let json = value as? [String: Any],
                       let items = json["items"] as? [[String: Any]] {
                        let videos = items.compactMap { VideoYoutubeModel(json: $0) }
                        seal.fulfill(videos)
                    } else {
                        seal.reject(NetworkError.invalidResponse)
                    }
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func fetchAvatarChannel(channelId: String) -> Promise<String> {
        let url = "\(BaseURL)/channels?part=snippet&id=\(channelId)&key=\(ApiKey)"
        return Promise { seal in
            AF.request(url).responseJSON {
                switch $0.result {
                case .success(let value):
                    guard let json = value as? [String: Any],
                          let items = json["items"] as? [[String: Any]],
                          let snippet = items.first?["snippet"] as? [String: Any],
                          let thumbnails = snippet["thumbnails"] as? [String: Any],
                          let defaultThumbnail = thumbnails["default"] as? [String: Any],
                          let avatarUrl = defaultThumbnail["url"] as? String else {
                        seal.reject(NSError(domain: "Invalid JSON response", code: 0, userInfo: nil))
                        return
                    }
                    
                    seal.fulfill(avatarUrl)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
