//
//  HistoryController.swift
//  RadioKun
//
//  Created by Nico on 30/09/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit
import CoreData


class HistoryController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
    let theme = ThemeManager.currentTheme();
    
    @IBOutlet weak var tableView : UITableView!;
    
    var controller : NSFetchedResultsController<Song>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor;
        
        tableView.delegate = self
        self.controller = DBUtil.fetchedResultsHistoryController();
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData(); // Use to update the list with any change that happen in core data
    }
    
    
    //how many groups (sections) of lines (rows)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1; // No need to separe the history in sections
    }
    
    
    // Number of lines for each group
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.sections?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! SongHistoryCell;
        
        // Set data in the cell
        let song = controller.fetchedObjects![indexPath.row];
        cell.configure(song);
        
        // Color configuration
        cell.backgroundColor = theme.backgroundColor;
        cell.bandLbl.textColor = theme.mainColor;
        cell.songLbl.textColor = theme.mainColor;
        cell.timestampLbl.textColor = theme.mainColor;
        
        tableView.separatorColor = theme.mainColor;
        
        // Set Favorite image depend on state
        // Filled = favorite(true), Empty = not favorite(false)
        let favoriteState = DBUtil.getSongFavoriteState(timeStamp: cell.timeStamp!);
        Util.setFavoriteBtnImage(favoriteBtn: cell.favoriteBtn, state: favoriteState);
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open the ViewController when successfully recognize a song
        // to show the full details of this song (song, band & lyrics)
        // Get Song
        let song = controller.fetchedObjects![indexPath.row];
        
        // Move to the next Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let resultController = storyboard.instantiateViewController(withIdentifier: "ResultController") as! ResultController;
        resultController.bandName = song.band!;
        resultController.songName = song.name!;
        resultController.lyricsName = song.lyric!;
        // This is the RecognitionController constant variable that is used for navigation
        navigationController?.pushViewController(resultController, animated: true);
    }
}
