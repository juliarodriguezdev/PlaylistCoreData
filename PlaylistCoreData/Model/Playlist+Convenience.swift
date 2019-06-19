//
//  Playlist+Convenience.swift
//  PlaylistCoreData
//
//  Created by julia rodriguez on 6/19/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import Foundation
import CoreData

// extension (Class Name) 
extension Playlist {
    
    @discardableResult
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: context)
        self.name = name
    }
}
