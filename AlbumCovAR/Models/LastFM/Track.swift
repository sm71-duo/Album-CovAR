//
//  LastFmTrack.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation

struct Track: Identifiable {
    var id = UUID()
    var duration: Int
    var url: String
    var name: String
    var rank: Int //@attr.rank in response
    var artist: Artist
}

extension Track: Codable {
    enum CodingKeys: String, CodingKey {
        case duration
        case url
        case name
        case rank = "@attr"
        case artist
    }
    
    enum RankKeys: String, CodingKey {
        case rank
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        duration = try values.decode(Int.self, forKey: .duration)
        url = try values.decode(String.self, forKey: .url)
        name = try values.decode(String.self, forKey: .name)
        
        let attrs = try values.nestedContainer(keyedBy: RankKeys.self, forKey: .rank)
        
        rank = try attrs.decode(Int.self, forKey: .rank)
        artist = try values.decode(Artist.self, forKey: .artist)
        
        
        
    }
}
