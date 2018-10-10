//
//  SongCell.swift
//  RadioKun
//
//  Created by Nico on 01/10/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class SongFavoriteCell: SongCell {
    
    @IBOutlet weak var songLbl: UILabel!;
    @IBOutlet weak var bandLbl: UILabel!;
    
    @IBOutlet weak var facebookBtn: UIButton!;
    @IBOutlet weak var favoriteBtn: UIButton!;
    
//    // Use as key when retriving data from CoreData
//    public var timeStamp: Date?;
    
    // Constructor - Configuration of how the cell will be populated
    override func configure(_ song: Song){
        super.configure(song);
        songLbl.text = song.name;
        bandLbl.text = song.band;
        
       
    }
    
    // Add to favorite or remove from there
    // Depend on the state of the favorite the icon will change(filled <-> empty)
   @IBAction func favoriteAction(_ sender: UIButton) {
        DBUtil.reverseFavorite(btn: sender);
    
    }
        
        
    @IBAction func facebookAction(_ sender: UIButton) {
        // Vlad - at phase 4 add function to share the selected song
    }
}
