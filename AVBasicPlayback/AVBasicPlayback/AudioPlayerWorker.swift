//
//  AudioPlayerWorker.swift
//  AVBasicPlayback
//
//  Created by Ryan Schanberger on 7/16/19.
//  Copyright © 2019 schanberger. All rights reserved.
//

import Foundation
import AVFoundation
import Cache

class AudioPlayerWorker {
    
    var player: AVPlayer!
    
    let diskConfig = DiskConfig(name: "DiskCache")
    let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
    
    lazy var storage: Cache.Storage? = {
        return try? Cache.Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
    }()
    
    // MARK: - Logic
    
    /// Plays a track either from the network if it's not cached or from the cache.
    func play(with url: URL) {
        // Trying to retrieve a track from cache asynchronously.
        storage?.async.entry(ofType: Data.self, forKey: url.absoluteString, completion: { result in
            let playerItem: CachingPlayerItem
            switch result {
            case .error:
                // The track is not cached.
                print("track was not cached, had to download")
                playerItem = CachingPlayerItem(url: url)
            case .value(let entry):
                // The track is cached.
                playerItem = CachingPlayerItem(data: entry.object, mimeType: "audio/mpeg", fileExtension: "mp3")
                print("played from cache")
            }
            playerItem.delegate = self
            self.player = AVPlayer(playerItem: playerItem)
            self.player.automaticallyWaitsToMinimizeStalling = false
            self.player.play()
        })
    }
    
    func pause() {
        player.pause()
    }
}


// MARK: - CachingPlayerItemDelegate
extension AudioPlayerWorker: CachingPlayerItemDelegate {
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        // A track is downloaded. Saving it to the cache asynchronously.
        storage?.async.setObject(data, forKey: playerItem.url.absoluteString, completion: { _ in })
    }
}

//IS THIS THE BEST PLACE/MANNER FOR THESE FUNCTIONS???

extension ViewController: CachingPlayerItemDelegate {
    
    func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded and ready for storing")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int) {
        print("\(bytesDownloaded)/\(bytesExpected)")
    }
    
    func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem) {
        print("Not enough data for playback. Probably because of the poor network. Wait a bit and try to play later.")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error) {
        print(error)
    }
    
}
