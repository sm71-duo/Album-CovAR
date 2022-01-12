//
//  LastFmImage.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation

struct LastFmImage: Identifiable {
    var id = UUID()
    var size: String
    var url: String //#text in response
}

extension LastFmImage: Codable {
    enum CodingKeys: String, CodingKey {
        case size
        case url = "#text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        size = try values.decode(String.self, forKey: .size)
        url = try values.decode(String.self, forKey: .url)
    }
}
