//
//  VideoYoutubeView.swift
//  MagicApp
//
//  Created by Cường Trần on 09/10/2023.
//

import SwiftUI
import PromiseKit
import RxSwift
import youtube_ios_player_helper_swift

struct VideoYoutubeView: View {
    @StateObject var vm = VideoYoutubeVM()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.videos) { video in
                    VideoItemView(videoModel: video)
                }
            }
        }
        .padding()
        .onAppear {
            vm.fetchData()
        }
        .environmentObject(vm)
    }
}

struct VideoItemView: View {
    @EnvironmentObject var vm   : VideoYoutubeVM
    let videoModel              : VideoYoutubeModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: videoModel.thumbnailURL) { returnImage in
                returnImage
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(20)
            } placeholder: { 
                ProgressView()
            }
            
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: "\(vm.avatarChannel)")) { returnImage in
                    returnImage
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: { 
                    ProgressView()
                }
                
                VStack(alignment: .leading) {
                    Text("\(videoModel.titleVideo)")
                        .lineLimit(2)
                        .font(.headline)
                        .bold()
                    HStack {
                        Text("\(videoModel.channelTitle)")
                        Image(systemName: "eye.fill")
                        Text("\(videoModel.views) views")
                    }
                    .foregroundColor(.gray)
                }
            }
        }
    }
}

struct VideoPlayerView: UIViewRepresentable {
    let videoId: String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(videoId: videoId)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        // No need to update the view in this example
    }
}

struct VideoYoutubeView_Previews: PreviewProvider {
    static var previews: some View {
        VideoYoutubeView()
    }
} 
