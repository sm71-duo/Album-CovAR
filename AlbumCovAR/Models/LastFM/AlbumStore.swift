//
//  AlbumStore.swift
//  AlbumCovAR
//
//  Created by Quan on 27/12/2021.
//

import Foundation

class AlbumStore: Decodable, ObservableObject {
    @Published var album: LastFmAlbum = LastFmAlbum.sampleAlbum
    
    private static var lastFmURL = "https://ws.audioscrobbler.com/2.0/"
    private static var apiKey = ProcessInfo.processInfo.environment["LASTFM_API_KEY"] ?? "Env variable not found"
    
    enum CodingKeys: CodingKey {
        case album
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album = try values.decode(LastFmAlbum.self, forKey: .album)
    }
    
    init() {
        
    }
    
    func fetchTestAlbum() {
        print("[STORE] start")
        
        guard let albumUrl = URL(string: Self.lastFmURL + "?method=album.getinfo&api_key=" + Self.apiKey + "&artist=Tyler,+the+creator&album=flower+boy&format=json") else {
            return
        }
        
        let request = URLRequest(url: albumUrl)
        
        print("[STORE] request: \(request)")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print("STORE: error: \(error)")
                return
            }
            
            if let data = data {
                print("[STORE] data: \(data)")
                DispatchQueue.main.async {
                    self.album = self.parseJsonData(data: data)
                    
                }
            }
        })
        print("[STORE] self.album: \(self.album)")
        
        task.resume()
    }
    
    func fetchAlbumByQuery(name: String, artist: String) {
        
        guard let albumUrl = URL(string: "\(Self.lastFmURL)?method=album.getinfo&api_key=\(Self.apiKey)&artist=\(artist)&album=\(name)&format=json") else {
            return
        }
        
        let request = URLRequest(url: albumUrl)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.album = self.parseJsonData(data: data)
                    
                }
            }
        })
        
        
        print(self.album.name)
        task.resume()
    }
    
    func fetchAlbumByARReferenceName(referenceName: String) {
        
        var artist: String
        var name: String
        
        let fullReferenceName = referenceName.components(separatedBy: " - ")
        
        artist = fullReferenceName[0].replacingOccurrences(of: " ", with: "+")
        name = fullReferenceName[1].replacingOccurrences(of: " ", with: "+")
        
        guard let albumUrl = URL(string: Self.lastFmURL + "?method=album.getinfo&api_key=" + Self.apiKey + "&artist=" + artist + "&album=" + name + "&format=json") else {
            return
        }
        
        let request = URLRequest(url: albumUrl)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.album = self.parseJsonData(data: data)
                    print("[CHECK] \(self.parseJsonData(data: data).name)")
                    print("[CHECK] \(self.parseJsonData(data: data).image[0].url)")
                    
                }
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> LastFmAlbum {
        let decoder = JSONDecoder()
        
        do {
            let albumStore = try decoder.decode(AlbumStore.self, from: data)
            self.album = albumStore.album
        } catch {
            print("ERROR: \(error)")
        }
        return album
    }

}
