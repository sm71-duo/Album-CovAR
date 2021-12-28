//
//  LastFmAlbum.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation
import SwiftUI

struct LastFmAlbum: Identifiable {
    var id = UUID()
    var artist: String
    var mbid: String
    var image: [LastFmImage]
    var tracks: [Track]
    var name: String
    var url: String
    var avgColor: Color
    var contrastColor: Color
    
    init(artist: String, mbid: String, image: [LastFmImage], tracks: [Track], name: String, url: String) {
        self.artist = artist
        self.mbid = mbid
        self.image = image
        self.tracks = tracks
        self.name = name
        self.url = url
        
        if(image.last != nil) {
            self.avgColor = setAverageColor(imageUrl: image.last?.url ?? "")
        } else {
            self.avgColor = Color("Black")
        }
        
        if(image.last != nil) {
            self.contrastColor = setContrastColor(imageUrl: image.last?.url ?? "")
        } else {
            self.contrastColor = Color("Black")
        }
        
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
        tracks = try tracklist.decode([Track].self, forKey: .track)
        
        if(image.last != nil) {
            avgColor = setAverageColor(imageUrl: image.last?.url ?? "")
        } else {
            avgColor = Color("Black")
        }
        
        if(image.last != nil) {
            contrastColor = setContrastColor(imageUrl: image.last?.url ?? "")
        } else {
            contrastColor = Color("Black")
        }
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

func setAverageColor (imageUrl: String) -> Color {

    let imageUrl = URL(string: imageUrl)!

    let imageData = try! Data(contentsOf: imageUrl)

    let image = UIImage(data: imageData)
    
    let uiColor = image?.averageColor ?? .clear
    return Color(uiColor)
}

func setContrastColor (imageUrl: String) -> Color {
    
    let avgColor = setAverageColor(imageUrl: imageUrl)
    
    var cString:String = hexStringFromColor(color: avgColor)
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return Color.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)
    let green =  CGFloat((rgbValue & 0x00FF00) >> 8)
    let blue = CGFloat(rgbValue & 0x0000FF)
    
    print((((red * 0.299) + (green * 0.587) + (blue * 0.114)) > 186) ? "[TEST] Black" : "[TEST] White")
    
    return (((red * 0.299) + (green * 0.587) + (blue * 0.114)) > 186) ?
    Color("Black") : Color("White");
}

func hexStringFromColor(color: Color) -> String {
    let components = color.cgColor?.components
    let r: CGFloat = components?[0] ?? 0.0
    let g: CGFloat = components?[1] ?? 0.0
    let b: CGFloat = components?[2] ?? 0.0

    let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    print(hexString)
    return hexString
 }

