//
//  Song.swift
//  AlbumCovAR
//
//  Created by Quan on 23/12/2021.
//

import Foundation

struct Song: Identifiable {
    var id = UUID()
    var name: String
    var artist: [String]
    var trackNumber: Int
    
    init(name: String, artist: [String], trackNumber: Int) {
        self.name = name
        self.artist = artist
        self.trackNumber = trackNumber
    }
}
