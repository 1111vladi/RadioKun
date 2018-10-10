//
//  FavoriteController.swift
//  RadioKun
//
//  Created by Nico on 08/10/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit
import CoreData

class FavoriteController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let theme = ThemeManager.currentTheme();
    
    @IBOutlet weak var tableView : UITableView!;
    
    var controller : NSFetchedResultsController<Song>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor;
        
        tableView.delegate = self
        self.controller = DBUtil.fetchedResultsFavoriteController();
        
        NotificationCenter.default.addObserver(self, selector: #selector(contextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.controller = DBUtil.fetchedResultsFavoriteController(); // Get again the data of the table to update if there were any changes
        tableView.reloadData(); // Use to update the list with any change that happen in core data
    }
    
    
    @objc func contextObjectsDidChange(_ notification: Notification) {
        print(notification)
//        print(notification.userInfo)
//        print(notification.description)
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<Song>, !updatedObjects.isEmpty {
            print("Fav");
            print(updatedObjects.first?.favorite);
            
//            // Get the cell to delete
//            let cell = SongFavoriteCell();
//            var song : Song?;
//            for songObj in controller.fetchedObjects!{
//                // Time_recog is the key for each song in coredata
//                // If it found the song in the list of fetchedObjects
//                if songObj.time_recog! == updatedObjects.first?.time_recog {
////                    song = updatedObjects.first!;
//                    print(updatedObjects.first?.name);
//                    print(songObj.name);
//                    song = songObj;
////                     cell.configure(updatedObjects.first!);
//                }
//            }
//            
//            if let songDel = song {
//                cell.configure(songDel);
//            } else {
//                return
//            }
//            
////            guard let songDel = song as! Song! else {
////                return
////            }
//            
//           
//            
//            // Get indexPath to delete
//            let indexPath = tableView.indexPath(for: cell);
//            // Delete it
//            tableView.deleteRows(at: [indexPath!], with: .right); // Use to update the list with any change that happen in core data
        }
        
//        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject>, !updatedObjects.isEmpty {
//            print(updatedObjects)
//        }
        
    }
    
    
    // Table
    // ---- Start ----
    //how many groups (sections) of lines (rows)
    func numberOfSections(in tableView: UITableView) -> Int {
        // Sections are separate with categories
        return controller.sections?.count ?? 0
    }
    
   
    // Group header text
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return controller.sections![section].name;
    }
    
    // Number of linee for each group
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! SongFavoriteCell;
        
        // Set data in the cell
        let song = controller.fetchedObjects![indexPath.row];
        cell.configure(song);
        
        // Color configuration
        cell.backgroundColor = theme.backgroundColor;
        cell.bandLbl.textColor = theme.mainColor;
        cell.songLbl.textColor = theme.mainColor;
        
        // Todo fix color of buttons...
        //        cell.facebookBtn.tintColor = theme.secondaryColor;
        //        cell.favoriteBtn.tintColor = theme.mainColor;
        
        // Set Favorite image depend on state
        // Filled = favorite(true), Empty = not favorite(false)
        let favoriteState = DBUtil.getSongFavoriteState(timeStamp: cell.timeStamp!);
        Util.setFavoriteBtnImage(favoriteBtn: cell.favoriteBtn, state: favoriteState);
        
        return cell
    }
    
    // Change theme of the header
    @objc func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView;
        header.backgroundView?.backgroundColor = theme.navigationBackgroundColor;
        header.textLabel?.textColor = theme.mainColor;
        header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 16);
        tableView.separatorColor = theme.mainColor;
    }
    // ----- END -----
    
    //*** Support Edit
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        //we only support delete
//        guard editingStyle == .delete else{
//            return
//        }
//
//        let context = DatabaseManager.manager.persistentContainer.viewContext
//        let object = controller.object(at: indexPath)
//
//        context.delete(object)
//        DatabaseManager.manager.saveContext()
        
        
    }
    
    //***

//}
//
//extension FavoriteController : NSFetchedResultsControllerDelegate
//{
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        //hey tableview, from now on you will get a bulk of command, please queue them and DO NOT do anything, yet.
//        tableView.beginUpdates()
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        //hey again, I finished with my junk, you can start commiting the queued commands now
//        tableView.endUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//
//        let indexSet = IndexSet(integer: sectionIndex)
//
//        switch type {
//        case .insert:
//            tableView.insertSections(indexSet, with: .automatic)
//        case .delete:
//            tableView.deleteSections(indexSet, with: .automatic)
//        default:
//            break
//        }
//
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//        switch type {
//        case .insert: //new target
//            tableView.insertRows(at: [newIndexPath!], with: .right)
//        case .delete: //target deleted
//            tableView.deleteRows(at: [indexPath!], with: .left)
//        case .move: //order of target changed (affected by sort desriptors)
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//        case .update:
//            print("Updating Table Favorite");
////            //a target's data updated , refresh cell content0
////            let data = self.controller.object(at: indexPath!)
////            if let cell = tableView.cellForRow(at: indexPath!) as? SongCell{
////                cell.configure(with: data)
////            }
//
//        }
//
//    }
//}
