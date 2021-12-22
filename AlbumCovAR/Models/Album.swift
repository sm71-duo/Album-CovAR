//
//  Album.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import Foundation

struct Album: Identifiable {
    var id = UUID()
    var name: String
    var artist: String
    var coverImageName: String
    
    init(name: String, artist: String, coverImageName: String) {
        self.name = name
        self.artist = artist
        self.coverImageName = coverImageName
    }
}
