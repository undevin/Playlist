//
//  SongController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import Foundation

class SongController {
    
    static let shared = SongController()
    
    var songs: [Song] = []
    
    func createSong(title: String, artist: String) {
        let newSong = Song(title: title, artist: artist)
        songs.append(newSong)
        print("Successfully added \(title) to My Playlist.")
        saveToPersistenceStore()
    }
    
    func deleteSong(song: Song) {
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
        print("Successfully deleted \(song.title) from My Playlist.")
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our songs: \(error) -- \(error.localizedDescription)")
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print("Error decoding our data into songs: \(error) -- \(error.localizedDescription)")
        }
    }
}
