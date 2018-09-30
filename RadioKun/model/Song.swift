//
//  Song.swift
//  RadioKun
//
//  Created by Nico on 30/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    
    // Here add any other computed property if needed
    // *
    // *
    
    
    class func createSongWith(name: String,
                              band: String,
                              category: String,
                              favorite: Bool,
                              timeRecognize: Date){
        
        let context = DatabaseManager.manager.persistentContainer.viewContext;
        // Create the data object to add in CoreData
        let song = Song(context: context);
        
        // Add data
        song.name = name;
        song.band = band;
        song.category = category;
        song.favorite = favorite;
        song.time_recog = timeRecognize;
        
        // Save in CoreData
        DatabaseManager.manager.saveContext();
    }
}
