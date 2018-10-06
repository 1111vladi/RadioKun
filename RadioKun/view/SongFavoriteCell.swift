//
//  SongCell.swift
//  RadioKun
//
//  Created by Nico on 01/10/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class SongFavoriteCell: SongCell {
    
    @IBOutlet weak var songLbl: UILabel!
    @IBOutlet weak var bandLbl: UILabel!
    // Constructor - Configuration of how the cell will be populated
    override func configure(_ song: Song){
//        song.name
//        song.band
//        song.category
//        song.favorite
//        song.time_recog
    }
    
    // Add to favorite or remove from there
    // Depend on the state of the favorite the icon will change(filled <-> empty)
   @IBAction func favoriteAction(_ sender: Any) {
    }
        
        
    @IBAction func facebookAction(_ sender: Any) {
        // Vlad - at phase 4 add function to share the selected song
    }
}
