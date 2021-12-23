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
    var tracklist: Tracklist
    
    init(name: String, artist: String, coverImageName: String, tracklist: Tracklist) {
        self.name = name
        self.artist = artist
        self.coverImageName = coverImageName
        self.tracklist = tracklist
    }
}

extension Album {
    static let sampleData: [Album] =
    [
        Album(
            name: "Flower Boy",
            artist: "Tyler, the Creator",
            coverImageName: "FlowerBoyAlbum",
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
                    ),
                    
                ]
            )
        ),
        Album(
            name: "Sand",
            artist: "Balthazar",
            coverImageName: "SandAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "Skin",
            artist: "Flume",
            coverImageName: "SkinAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "Damn",
            artist: "Kendrick Lamar",
            coverImageName: "DamnAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "For Ever",
            artist: "Jungle",
            coverImageName: "ForEverAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "Loving In Stereo",
            artist: "Jungle",
            coverImageName: "LovingInStereoAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "KIDS SEE GHOSTS",
            artist: "KIDS SEE GHOSTS",
            coverImageName: "KidsSeeGhostsAlbum",
            tracklist: Tracklist(
                songs: []
            )
        ),
        Album(
            name: "Hi, this is Flume",
            artist: "Flume",
            coverImageName: "HiThisIsFlumeAlbum",
            tracklist: Tracklist(
                songs: []
            )
        )
    ]
}

