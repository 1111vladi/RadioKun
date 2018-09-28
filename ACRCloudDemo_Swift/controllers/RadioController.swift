//
//  ViewController.swift
//  MyTest
//
//  Created by Vladi on 8/22/18.
//  Copyright © 2018 Vladi. All rights reserved.
//

import UIKit
import AVFoundation

class RadioController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
 
    // Here add categories and in each one add the name of the radio
    private let stationDicArr = [
        "HeavyMetal":
            ["Met al Metal"],
        "Jazz":
            ["Jazzi", "Mooze"],
        
    ]
    
    // Name of the radios, needs to be the same as the one in stationDicArr
    private let radioDic = [
        "Met al Metal":"http://stream.laut.fm/metal-fm-com",
        "Jazzi":"http://streaming.radio.co/s774887f7b/listen",
        "Mooze":""
    ]
    
    var stationDicArrKeyCopy : [String] = [];
    
    private var player : AVPlayer?;
    // Test for theme manager
    let theme = ThemeManager.currentTheme()
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        stationDicArrKeyCopy = Array(stationDicArr.keys);
        // Test for theme manager
        self.view.backgroundColor = theme.backgroundColor;
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stationDicArrKeyCopy.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stationDicArr[stationDicArrKeyCopy[section]]!.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = stationDicArr[stationDicArrKeyCopy[indexPath.section]]![indexPath.row];
        cell.textLabel?.textColor = theme.mainColor;
        cell.backgroundColor = theme.backgroundColor;
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stationDicArrKeyCopy[section];
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let radioKey = stationDicArr[stationDicArrKeyCopy[indexPath.section]]![indexPath.row];
        
        let radioUrl = radioDic[radioKey]!;
        
        playRadio(radioUrl);
    }
    
    // Change theme of the header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView;
        header.backgroundView?.backgroundColor = theme.navigationBackgroundColor;
        header.textLabel?.textColor = theme.mainColor;
        header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 16);
        tableView.separatorColor = theme.mainColor;
    }
    
    
    @IBAction func scanSongAction(_ sender: Any) {
        // Vlad's work - Alert window which scan the song that is playing
        // Won't work if 'player' isn't playing (player == nil) -> indicate the user in the alert that will pop-up
    }
    
    // Give the radio url and play the radio
    func playRadio(_ radioUrl : String){
        
        guard let url = URL(string: radioUrl) else{
            return
        }
        
        // Then start the new radio
        player = AVPlayer(url: url);
        player?.play();
    }
    
}

