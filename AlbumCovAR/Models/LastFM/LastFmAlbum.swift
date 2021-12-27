//
//  LastFmAlbum.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation

struct LastFmAlbum: Identifiable {
    var id = UUID()
    var artist: String
    var mbid: String
    var image: [LastFmImage]
    var tracks: [LastFmTrack]
    var name: String
    var url: String
    
    init(artist: String, mbid: String, image: [LastFmImage], tracks: [LastFmTrack], name: String, url: String) {
        self.artist = artist
        self.mbid = mbid
        self.image = image
        self.tracks = tracks
        self.name = name
        self.url = url
    }
}

extension LastFmAlbum: Codable {
    enum CodingKeys: String, CodingKey {
        case artist
        case mbid
        case image
        case tracks
        case name
        case url
    }
    
    enum TracksKey: String, CodingKey {
        case track
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        artist = try values.decode(String.self, forKey: .artist)
        mbid = try values.decode(String.self, forKey: .mbid)
        name = try values.decode(String.self, forKey: .name)
        url = try values.decode(String.self, forKey: .url)
        image = try values.decode([LastFmImage].self, forKey: .image)
        
        let tracklist = try values.nestedContainer(keyedBy: TracksKey.self, forKey: .tracks)
        tracks = try tracklist.decode([LastFmTrack].self, forKey: .track)
    }
}

extension LastFmAlbum {
    static let sampleAlbum: LastFmAlbum = LastFmAlbum(
        artist: "",
        mbid: "",
        image: [],
        tracks: [],
        name: "",
        url: ""
    )
    
}

