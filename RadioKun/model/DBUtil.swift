//
//  DBUtil.swift
//  RadioKun
//
//  Created by Nico on 30/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit
import CoreData

class DBUtil {
    
    // Get all Songs for HistoryController
    static func fetchedResultsHistoryController() -> NSFetchedResultsController<Song>{
        
        // Setup request
        let request : NSFetchRequest<Song> = Song.fetchRequest();
        request.predicate = nil // Filter can be add here
        request.sortDescriptors = [NSSortDescriptor(key: "time_recog", ascending: true)]; // The newest songs will be first
        
        // Setup results controller
        let context = DatabaseManager.manager.persistentContainer.viewContext;
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "time_recog", cacheName: nil);
        
        // Run query
        try? controller.performFetch();
        
        // Return results
        return controller;
    }
    
    // No need for now, both functions does the same pretty much (no filters)
//    // Get all Songs for FavoriteController
//    static func fetchedResultsFavoriteController() -> NSFetchedResultsController<Song>{
//
//        // Setup request
//        let request : NSFetchRequest<Song> = Song.fetchRequest();
//        request.predicate = nil // Filter can be add here
//        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]; // Sort depend on category
//
//        // Setup results controller
//        let context = DatabaseManager.manager.persistentContainer.viewContext;
//        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "time_stamp", cacheName: nil);
//
//        // Run query
//        try? controller.performFetch();
//
//        // Return results
//        return controller;
//    }
    
    // Change favorite for the song which the button was pressed from
    // It will always change the boolean to the other option (false -> true, true -> false)
    static func reverseFavorite(btn sender: UIButton){
        
        
//        //get the object
//        let object = controller.object(at: indexPath)
//        //update the data
//        object.isAlive = value
//        //command+s (save)
//        DatabaseManager.manager.saveContext()
    }
}
