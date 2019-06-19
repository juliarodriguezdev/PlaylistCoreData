//
//  SongController.swift
//  PlaylistCoreData
//
//  Created by julia rodriguez on 6/19/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
    // Singleton
    // Shared Instance
    static let sharedInstance = SongController()
    
    // CRUDS
    // Create
    
    func createNewSongWith(title: String, artist: String, playlist: Playlist) {
        Song(title: title, artist: artist, playlist: playlist)
        PlaylistController.sharedInstance.saveToPersistentStore()
    }
    
    // Delete
    func delete(song: Song) {
        if let moc = song.managedObjectContext {
            moc.delete(song)
            PlaylistController.sharedInstance.saveToPersistentStore()
        }
    }
    
    // Save
    
}
