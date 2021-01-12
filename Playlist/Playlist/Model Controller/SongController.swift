//
//  SongController.swift
//  Playlist
//
//  Created by Devin Flora on 1/11/21.
//

import Foundation

class SongController {
    
    // Shared instance
    static let shared = SongController()
    
    //Source of Truth (S.O.T)
    var songs: [Song] = []
        
    //CRUD Methods
    //Create
    func createSong(title: String, artist: String) {
        let song = Song(title: title, artist: artist)
        songs.append(song)
        saveToPersistenceStore()
    }
    
    //Read - Not needed for a bit.
    
    // TODO: - Update
    
    //Delete
    func deleteSong(songToDelete: Song) {
        guard let index = songs.firstIndex(of: songToDelete) else { return }
        songs.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistance
    
    // fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}//End of Class
