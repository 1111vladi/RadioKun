//
//  HistoryController.swift
//  RadioKun
//
//  Created by Nico on 30/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit
import CoreData

// TODO - History and Favorite will be similar ViewController? If so make a super class which they will change only the needed parts...
class HistoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let theme = ThemeManager.currentTheme();
    
    @IBOutlet weak var tableView : UITableView!;
    
    var controller : NSFetchedResultsController<Song>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor;
        
        tableView.delegate = self
        self.controller = DBUtil.fetchedResultsHistoryController();
        
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableView.automaticDimension;
       
//        controller.delegate = self //the controller will update us with very interesting events
    }
    
    //MARK: - TableView
    
    //how many groups (sections) of lines (rows)
    func numberOfSections(in tableView: UITableView) -> Int {
        //sections conut is uinique lastNames count
//        return controller.sections?.count ?? 0
        return 1;
    }
    
    // TEST
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
//    //group header text
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return controller.sections![section].name;
//    }
    
    //number of line for each group
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return controller.sections![section].numberOfObjects
        return controller.sections?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! SongHistoryCell;
        
//        cell.configure(with: controller.object(at: indexPath))
//        cell.textLabel?.text = controller.fetchedObjects![indexPath.row].name;
        let song = controller.fetchedObjects![indexPath.row];
        cell.configure(song);
//        cell.delegate = self
        
        return cell
    }
    
    // TODO - Add once RecognizeController is done
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // Open the ViewController when successfully recognize a song
//        // to show the full details of this song (song, band & lyrics)
//    }
    
}

//extension ListViewController : TargetCellDelegate
//{
//
//    func targetCell(_ cell: TargetCell, changeValueForIsAlive value: Bool) {
//        //find index for row
//        guard let indexPath = tableView.indexPath(for: cell) else{
//            return
//        }
//
//        //get the object
//        let object = controller.object(at: indexPath)
//        //update the data
//        object.isAlive = value
//        //command+s (save)
//        DatabaseManager.manager.saveContext()
//    }
//
//}
//
//extension ListViewController : NSFetchedResultsControllerDelegate
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
//            //a target's data updated , refresh cell content0
//            let data = self.controller.object(at: indexPath!)
//            if let cell = tableView.cellForRow(at: indexPath!) as? TargetCell{
//                cell.configure(with: data)
//            }
//
//        }
//        
//    }
//
//}
