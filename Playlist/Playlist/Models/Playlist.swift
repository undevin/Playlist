//
//  Playlist.swift
//  Playlist
//
//  Created by Devin Flora on 1/12/21.
//

import Foundation

class Playlist: Codable {
    
    let title: String
    var songs: [Song]
    
    init(title: String, songs: [Song] = []) {
        self.title = title
        self.songs = songs
    }
}//End of Class

extension Playlist: Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.title == rhs.title && lhs.songs == rhs.songs
    }
}
