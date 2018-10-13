//
//  ResultController.swift
//  RadioKun
//
//  Created by Vladi on 10/7/18.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var lyricsLabel: UILabel!
    @IBOutlet weak var bandLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    public var lyricsName = "";
    public var bandName = "";
    public var songName = "";
    public var genreName = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songLabel?.text = songName;
        bandLabel?.text = bandName;
        lyricsLabel?.text = lyricsName;
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
