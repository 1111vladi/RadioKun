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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData(); // Use to update the list with any change that happen in core data
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

}
