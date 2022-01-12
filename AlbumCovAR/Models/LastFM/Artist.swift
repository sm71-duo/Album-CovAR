//
//  LastFmArtist.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation

struct Artist: Identifiable {
    var id = UUID()
    var url: String
    var name: String
    var mbid: String
}

extension Artist: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case name
        case mbid
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try values.decode(String.self, forKey: .url)
        name = try values.decode(String.self, forKey: .name)
        mbid = try values.decode(String.self, forKey: .mbid)
        
        
        
    }
}
