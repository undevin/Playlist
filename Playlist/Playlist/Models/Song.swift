//
//  Song.swift
//  Playlist
//
//  Created by Devin Flora on 1/11/21.
//

import Foundation

class Song: Codable {
    
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}//End of Class

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
}

