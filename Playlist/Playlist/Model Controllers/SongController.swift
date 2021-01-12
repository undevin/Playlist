//
//  SongController.swift
//  Playlist
//
//  Created by Devin Flora on 1/11/21.
//

import Foundation

class SongController {
        
    // MARK: - CRUD Methods
    //Create
    static func createSong(title: String, artist: String, playlist: Playlist) {
        let song = Song(title: title, artist: artist)
        playlist.songs.append(song)
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    //Delete
    static func deleteSong(songToDelete: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: songToDelete) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistenceStore()
    }
}//End of Class
