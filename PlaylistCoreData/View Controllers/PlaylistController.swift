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
    var playlists: [Playlist] {
        // Create a NSFetchRequest that specifically references our Playlist model object
        let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
        // Use that Fetch Request to ask the managedObjectContext for all Playlist model objects that exist inside of that MOC
        // Nil Coalescing if true pass this ?? else do this
        return (try? CoreDataStack.managedObjectContext.fetch(request)) ?? []
    }
    
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
