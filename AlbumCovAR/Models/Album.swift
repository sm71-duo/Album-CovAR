//
//  Album.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import Foundation
import SwiftUI

struct Album: Identifiable {
    var id = UUID()
    var name: String
    var artist: String
    var coverImageName: String
    var avgColorHex: String
    var avgColor: Color
    var contrastColor: Color
    var spotifyUri: String
    var tracklist: Tracklist
    
    init(name: String, artist: String, coverImageName: String, avgColorHex: String, spotifyUri: String, tracklist: Tracklist) {
        self.name = name
        self.artist = artist
        self.coverImageName = coverImageName
        self.avgColorHex = avgColorHex
        self.avgColor = hexStringToUIColor(hex: avgColorHex)
        self.contrastColor = contrastColorBasedonAvgColor(hexColor: avgColorHex)
        self.spotifyUri = spotifyUri
        self.tracklist = tracklist
    }
}

func hexStringToUIColor (hex:String) -> Color {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return Color.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return Color(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0
    )
}

func contrastColorBasedonAvgColor (hexColor: String) -> Color {
    
    var cString:String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
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
    
    return (((red * 0.299) + (green * 0.587) + (blue * 0.114)) > 186) ?
    Color("Black") : Color("White");
}

extension Album {
    static let sampleData: [Album] =
    [
        Album(
            name: "Flower Boy",
            artist: "Tyler, the Creator",
            coverImageName: "Tyler, the Creator - Flower Boy Cover",
            avgColorHex: "#B67022",
            spotifyUri: "2nkto6YNI4rUYTLqEwWJ3o?si",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Foreword",
                        artist: ["Tyler, The Creator", "Rex Orange County"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Where This Flower Blooms",
                        artist: ["Tyler, The Creator", "Frank Ocean"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "Sometimes...",
                        artist: ["Tyler, The Creator"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "See You Again",
                        artist: ["Tyler, The Creator", "See You Again"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "Who Dat Boy",
                        artist: ["Tyler, The Creator", "A$AP Rocky"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Pothole",
                        artist: ["Tyler, The Creator", "Jaden"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Garden Shed",
                        artist: ["Tyler, The Creator", "Estelle"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "Boredom",
                        artist: ["Tyler, The Creator", "Rex Orange County", "Anna of the North"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "I Ain't Got Time!",
                        artist: ["Tyler, The Creator"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "911/Mr. Lonely",
                        artist: ["Tyler, The Creator", "Frank Ocean", "Steve Lacy"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "Droppin' Seeds",
                        artist: ["Tyler, The Creator", "Lil' Wayne"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "November",
                        artist: ["Tyler, The Creator"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "Glitter",
                        artist: ["Tyler, The Creator"],
                        trackNumber: 13
                    ),
                    Song(
                        name: "Enjoy Right Now, Today",
                        artist: ["Tyler, The Creator", "Jaden"],
                        trackNumber: 14
                    )
                ]
            )
        ),
        Album(
            name: "Sand",
            artist: "Balthazar",
            coverImageName: "Balthazar - Sand Cover",
            avgColorHex: "#9A9A99",
            spotifyUri: "0aYwzFnbFur2SEyJKKS0LD",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Moment",
                        artist: ["Balthazar"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Losers",
                        artist: ["Balthazar"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "On A Roll",
                        artist: ["Balthazar"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "I Want You",
                        artist: ["Balthazar"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "You Won't Come Around",
                        artist: ["Balthazar"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Linger On",
                        artist: ["Balthazar"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Hourglass",
                        artist: ["Balthazar"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "Passing Through",
                        artist: ["Balthazar"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "Leaving Antwerp",
                        artist: ["Balthazar"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "Halfway",
                        artist: ["Balthazar"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "Powerless",
                        artist: ["Balthazar"],
                        trackNumber: 11
                    )
                ]
            )
        ),
        Album(
            name: "Skin",
            artist: "Flume",
            coverImageName: "Flume - Skin Cover",
            avgColorHex: "#A67CA7",
            spotifyUri: "1sxqYNzozsrgu0Vh6jQ6Lr",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Helix",
                        artist: ["Flume"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Never Be Like You",
                        artist: ["Flume", "Kai"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "Lose It",
                        artist: ["Flume", "VIC MENSA"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "Numb & Getting Colder",
                        artist: ["Flume", "KUČKA"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "Say It",
                        artist: ["Flume", "Tove Lo"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Wall Fuck",
                        artist: ["Flume"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Pika",
                        artist: ["Flume"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "Smake & Retrobution",
                        artist: ["Flume", "Vic Stapbles", "KUČKA"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "3",
                        artist: ["Flume"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "When Everything Was New",
                        artist: ["Flume"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "You Know",
                        artist: ["Flume", "Allan Kingdom", "Raekwon"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "Take a Chance",
                        artist: ["Flume", "Little Dragon"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "Innocence",
                        artist: ["Flume", "AlunaGeroge"],
                        trackNumber: 13
                    ),
                    Song(
                        name: "Like Water",
                        artist: ["Flume", "MNDR"],
                        trackNumber: 14
                    ),
                    Song(
                        name: "Free",
                        artist: ["Flume"],
                        trackNumber: 15
                    ),
                    Song(
                        name: "Tiny Cities",
                        artist: ["Flume", "Beck"],
                        trackNumber: 16
                    ),
                ]
            )
        ),
        Album(
            name: "DAMN.",
            artist: "Kendrick Lamar",
            coverImageName: "Kendrick Lamar - DAMN Cover",
            avgColorHex: "#95717d",
            spotifyUri: "4eLPsYPBmXABThSJ821sqY",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "BLOOD.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "DNA.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "YAH.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "ELEMENT.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "FEEL.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "LOYALTY.",
                        artist: ["Kendrick Lamar", "Rihanna"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "PRIDE.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "HUMBLE.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "LUST.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "LOVE.",
                        artist: ["Kendrick Lamar", "Zacari"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "XXX.",
                        artist: ["Kendrick Lamar", "U2"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "FEAR.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "GOD.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 13
                    ),
                    Song(
                        name: "DUCKWORTH.",
                        artist: ["Kendrick Lamar"],
                        trackNumber: 14
                    )
                ]
            )
        ),
        Album(
            name: "For Ever",
            artist: "Jungle",
            coverImageName: "Jungle - For Ever Cover",
            avgColorHex: "#d6a13a",
            spotifyUri: "5gYCZgmXzzWXxOCb9fMfBm",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Smile",
                        artist: ["Jungle"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Heavy, California",
                        artist: ["Jungle"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "Beat 54 (All Good Now)",
                        artist: ["Jungle"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "Cherry",
                        artist: ["Jungle"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "Happy Man",
                        artist: ["Jungle"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Casio",
                        artist: ["Jungle"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Mama Oh No",
                        artist: ["Jungle"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "House In LA",
                        artist: ["Jungle"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "Give Over",
                        artist: ["Jungle"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "Cosurmyne",
                        artist: ["Jungle"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "Home",
                        artist: ["Jungle"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "(More and More) It Ain't Easy",
                        artist: ["Jungle"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "Pray",
                        artist: ["Jungle"],
                        trackNumber: 13
                    ),
                ]
            )
        ),
        Album(
            name: "Loving In Stereo",
            artist: "Jungle",
            coverImageName: "Jungle - Loving In Stereo Cover",
            avgColorHex: "#ccc3b5",
            spotifyUri: "1hykVcbmenjAoG7wwoXmCV",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Dry Your Tears",
                        artist: ["Jungle"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Keep Moving",
                        artist: ["Jungle"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "All Of The Time",
                        artist: ["Jungle"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "Romeo",
                        artist: ["Jungle", "Bas"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "Lifting You",
                        artist: ["Jungle"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Bonnie Hill",
                        artist: ["Jungle"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Fire",
                        artist: ["Jungle"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "Talk About It",
                        artist: ["Jungle"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "No Rules",
                        artist: ["Jungle"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "Truth",
                        artist: ["Jungle"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "What D'You Know About Me?",
                        artist: ["Jungle"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "Just Fly, Don't Worry",
                        artist: ["Jungle"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "Goodbye My Love",
                        artist: ["Jungle", "Priya Ragu"],
                        trackNumber: 13
                    ),
                    Song(
                        name: "Can't Stop The Stars",
                        artist: ["Jungle"],
                        trackNumber: 14
                    )
                ]
            )
        ),
        Album(
            name: "KIDS SEE GHOSTS",
            artist: "KIDS SEE GHOSTS",
            coverImageName: "KIDS SEE GHOSTS - KIDS SEE GHOSTS Cover",
            avgColorHex: "#af9691",
            spotifyUri: "6pwuKxMUkNg673KETsXPUV",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Feel The Love",
                        artist: ["KIDS SEE GHOSTS", "Pusha T"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Fire",
                        artist: ["KIDS SEE GHOSTS"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "4th Dimension",
                        artist: ["KIDS SEE GHOSTS", "Louis Prima"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "Freeee (Ghost Town Pt. 2)",
                        artist: ["KIDS SEE GHOSTS", "Ty Dolla $ign"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "Reborn",
                        artist: ["KIDS SEE GHOSTS"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Kids See Ghosts",
                        artist: ["KIDS SEE GHOSTS", "Yasiin Bey"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Cudi Montage",
                        artist: ["KIDS SEE GHOSTS"],
                        trackNumber: 7
                    )
                ]
            )
        ),
        Album(
            name: "Hi This Is Flume",
            artist: "Flume",
            coverImageName: "Flume - Hi This Is Flume Cover",
            avgColorHex: "7f6e48",
            spotifyUri: "2Vx9FC6Um8i6kEtY7HNswB",
            tracklist: Tracklist(
                songs: [
                    Song(
                        name: "Hi This is Flume",
                        artist: ["Flume"],
                        trackNumber: 1
                    ),
                    Song(
                        name: "Ecdysis",
                        artist: ["Flume"],
                        trackNumber: 2
                    ),
                    Song(
                        name: "High Beams",
                        artist: ["Flume", "HWLS", "slowthai"],
                        trackNumber: 3
                    ),
                    Song(
                        name: "Jewel",
                        artist: ["Flume"],
                        trackNumber: 4
                    ),
                    Song(
                        name: "╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌╫§╜φ°⌂▌",
                        artist: ["Flume"],
                        trackNumber: 5
                    ),
                    Song(
                        name: "Dreamtime",
                        artist: ["Flume"],
                        trackNumber: 6
                    ),
                    Song(
                        name: "Is It Cold In The Water? - Flume & Eprom Remix",
                        artist: ["Flume", "SOPHIE", "Eprom"],
                        trackNumber: 7
                    ),
                    Song(
                        name: "How To Build A Relationship",
                        artist: ["Flume", "JPEGMAFIA"],
                        trackNumber: 8
                    ),
                    Song(
                        name: "Wormhole",
                        artist: ["Flume"],
                        trackNumber: 9
                    ),
                    Song(
                        name: "Voices",
                        artist: ["Flume", "KUČKA", "SOPHIE"],
                        trackNumber: 10
                    ),
                    Song(
                        name: "MUD",
                        artist: ["Flume"],
                        trackNumber: 11
                    ),
                    Song(
                        name: "Upgrade",
                        artist: ["Flume"],
                        trackNumber: 12
                    ),
                    Song(
                        name: "71m3",
                        artist: ["Flume"],
                        trackNumber: 13
                    ),
                    Song(
                        name: "Vitality",
                        artist: ["Flume"],
                        trackNumber: 14
                    ),
                    Song(
                        name: "Daze 22.00",
                        artist: ["Flume"],
                        trackNumber: 15
                    ),
                    Song(
                        name: "Amber",
                        artist: ["Flume"],
                        trackNumber: 16
                    ),
                    Song(
                        name: "Spring",
                        artist: ["Flume", "Eprom"],
                        trackNumber: 17
                    ),
                ]
            )
        )
    ]
}

