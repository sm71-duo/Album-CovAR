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
                songs: []
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

