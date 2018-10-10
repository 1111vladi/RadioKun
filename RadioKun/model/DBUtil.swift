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
    
    // Get all Songs for FavoriteController
    static func fetchedResultsFavoriteController() -> NSFetchedResultsController<Song>{

        // Setup request
        let request : NSFetchRequest<Song> = Song.fetchRequest();
        request.predicate = NSPredicate(format: "favorite = true") // Only get the songs which are marked as favorite(true)
        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]; // Sort depend on category

        // Setup results controller
        let context = DatabaseManager.manager.persistentContainer.viewContext;
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "category", cacheName: nil);

        // Run query
        try? controller.performFetch();

        // Return results
        return controller;
    }
    
    // Change favorite for the song which the button was pressed from
    // It will always change the boolean to the other option (false -> true, true -> false)
    static func reverseFavorite(btn sender: UIButton){
        
        // Get the Song timeStamp from the cell it self
        let cell = sender.superview?.superview as! SongCell;
        let timeStamp = cell.timeStamp!;
        
        let controller = getSongDateFilter(timeStamp: timeStamp);
        
        let song = controller.fetchedObjects![0];
        
        //update the data
        song.favorite = !song.favorite;
        //command+s (save)
        DatabaseManager.manager.saveContext();
        
        Util.setFavoriteBtnImage(favoriteBtn: sender, state: song.favorite);
        
        // TODO - Nico
        
        // When new favorite is false
        // remove from favorite list
        
//        let tableView = cell.superview as! UITableView;
//        let indexPath = tableView.indexPath(for: cell);
//        tableView.deleteRows(at: [indexPath!], with: .right);
//
        
    }
    
    // By the timestamp (key in coredata) get the state of favorite
    static func getSongFavoriteState(timeStamp: Date) -> Bool{
        
        let controller = getSongDateFilter(timeStamp: timeStamp);
        
        let song = controller.fetchedObjects![0];
        
        return song.favorite;
        
    }
    
    // Get only a specific data from coredata depend on the key (timestamp)
    private static func getSongDateFilter(timeStamp: Date) -> NSFetchedResultsController<Song>{
        // Setup request
        let request : NSFetchRequest<Song> = Song.fetchRequest();
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Song.time_recog), timeStamp as CVarArg) // Only get the song which fit with timestamp
        request.sortDescriptors = [NSSortDescriptor(key: "time_recog", ascending: true)]; // Sort depend on category
        
        // Setup results controller
        let context = DatabaseManager.manager.persistentContainer.viewContext;
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "category", cacheName: nil);
        
        // Run query
        try? controller.performFetch();
        
        return controller
    }
}
