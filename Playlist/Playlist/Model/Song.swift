//
//  Song.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import Foundation

class Song: Codable {
    
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return rhs.title == lhs.title && rhs.artist == lhs.artist
    }
}
