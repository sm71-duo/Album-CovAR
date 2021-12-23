//
//  Tracklist.swift
//  AlbumCovAR
//
//  Created by Quan on 23/12/2021.
//

import Foundation

struct Tracklist: Identifiable {
    var id = UUID()
    var songs: [Song]
    var songAmount: Int
    
    init(songs: [Song]) {
        self.songs = songs
        self.songAmount = songs.count
    }
}
