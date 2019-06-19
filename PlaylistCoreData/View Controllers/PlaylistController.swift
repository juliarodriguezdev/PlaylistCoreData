//
//  File.swift
//  PlaylistCoreData
//
//  Created by julia rodriguez on 6/19/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    // Singleton
    // Shared Instances
    static let sharedInstance = PlaylistController()
    
    // Source of Truth
    var playlists: [Playlist] = []
    
    // CRUD Functions
    // Create
    func createPlaylistWith(name: String) {
        // From @Discardable Result or _ = Playlist(name: name)
        Playlist(name: name)
        saveToPersistentStore()
    }

    // Delete
    func delete(playlist: Playlist) {
        if let moc = playlist.managedObjectContext {
            moc.delete(playlist)
            saveToPersistentStore()
        }
    }
    
    // Save
    func saveToPersistentStore() {
        let moc = CoreDataStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving to moc: \(error.localizedDescription)")
        }
    }
}
