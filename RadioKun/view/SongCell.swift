//
//  SongCell.swift
//  RadioKun
//
//  Created by Nico on 01/10/2018.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

protocol SongCellDelegate : NSObjectProtocol{
    
    func songCell(_ cell: SongFavoriteCell, isFavorite: Bool);
}

// Main class which History & Favorite SongCells will inheritance, as they are very similar
class SongCell: UITableViewCell {
    
    weak var delegate : SongCellDelegate?;
    
    // Default Constructor - Configuration of how the cell will be populated
    // ** Override func configure with the populated items depend on the cell **
    func configure(_ song: Song){
//        song.name
//        song.band
//        song.category
//        song.favorite
//        song.time_recog
    }
    
    
   
    
}
