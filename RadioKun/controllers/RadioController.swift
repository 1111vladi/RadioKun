//
//  ViewController.swift
//  MyTest
//
//  Created by Vladi on 8/22/18.
//  Copyright © 2018 Vladi. All rights reserved.
//

import UIKit
import AVFoundation

class RadioController: UIViewController, UITableViewDataSource{
    
    // Theme manager to manage all colors type of each section
    let theme = ThemeManager.currentTheme();
    
    private var player : AVPlayer?;
    
    // Dictionary of each category and their radio names
    // Here add categories and in each one add the name of the radio
    private var stationDicArr : [String:[String]] = [:];
    
    // Dictionary of the radio name with radio url
    // Name of the radios, needs to be the same as the one in stationDicArr
    private var radioDic : [String:String]  = [:];

    // Save the key of each category for easier access and order
    private var stationDicArrKey : [String] = [];
    
    // Used for having a reference of the previous radio
    private var previousRadioSender : UIButton?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = theme.backgroundColor;
        
        stationDicArr = [
            "HeavyMetal":["Met al Metal"],
            "Jazz":["Jazzi"],
            "Folk":["Liscio e Folk"],
            "Classical":["WDAV Classica"],
            "Rock":["Jewish Rock"],
            "Country":["WBGK 101.1 FM Newport Village"],
            "Swing":["Gorindo"],
            "Trance":["Digital Impulse"],
            
        ];
       
        radioDic = [
        "Met al Metal":"http://stream.laut.fm/metal-fm-com",
        "Jazzi":"http://streaming.radio.co/s774887f7b/listen",
        "Mooze":"",
        "Liscio e Folk":"http://dj.mediastreaming.it:7012",
        "WDAV Classica":"http://audio-mp3.ibiblio.org:8000/wdav-24k",
        "Jewish Rock":"http://sc11.spacialnet.com/stream/2554/",
        "Gorindo":"http://streaming.radionomy.com/Gorindo?lang=en-US&appName=iTunes.m3u",
        "Digital Impulse":"http://5.39.71.159:8554/;stream;",
        "WBGK 101.1 FM Newport Village":"http://ice6.securenetsystems.net/WBGK"
        ];
        
        stationDicArrKey = Array(stationDicArr.keys);
        
       
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stationDicArrKey.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return stationDicArr[stationDicArrKey[section]]!.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = theme.backgroundColor;
        let cellContainerArr = cell.subviews[0].subviews;
        
        // Configurate the Label of the cell
        let cellLbl = cellContainerArr[1] as! UILabel;
        cellLbl.text = stationDicArr[stationDicArrKey[indexPath.section]]![indexPath.row];
        cellLbl.textColor = theme.mainColor;
        
        // Configurate the Button of the cell
        let cellBtn = cellContainerArr[0] as! UIButton;
        cellBtn.addTarget(self, action: #selector(playRadio(_:)), for: .touchUpInside);  // Add the action of what the button will do
        cellBtn.tintColor = theme.mainColor; // Todo - change to a brighter version of the main color to stand out more
        return cell;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stationDicArrKey[section];
    }
    
    // Change theme of the header
    @objc func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView;
        header.backgroundView?.backgroundColor = theme.navigationBackgroundColor;
        header.textLabel?.textColor = theme.mainColor;
        header.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 16);
        tableView.separatorColor = theme.mainColor;
    }
    
    
    @IBAction func scanSongAction(_ sender: Any) {
        // Vlad's work - Alert window which scan the song that is playing
        // Won't work if 'player' isn't playing (player == nil) -> indicate the user in the alert that will pop-up
        print("Amm which song is it..?");
    }
    
    // Give the radio url and play the radio
    @objc func playRadio(_ sender: UIButton){
        // Get the super view(cell) of the sender(button) to arrive to the label(radio name)
        let radioLbl = sender.superview?.subviews[1] as! UILabel;
        let radioUrl = radioDic[radioLbl.text!]!; // With the name of the radio get the url
        
        guard let url = URL(string: radioUrl) else{
            return
        }

        // Change the image of the previous button to play if a radio was playing
        if let preRadio = previousRadioSender {
            
            preRadio.setImage(UIImage(named: "play"), for: .normal);
            
            // It's the same radio so the user wants to stop to listen to this radio
            if preRadio == sender {
                player?.pause();
                return // Don't need to continue as the user stopped to listen to this radio
            }
        }
        
        // Then start the new radio
        player = AVPlayer(url: url);
        player?.play();
        
        // Change this button image to pause indicating that the radio is playing and could be paused
        sender.setImage(UIImage(named: "pause"), for: .normal);
        
        // Reset reference for the current radio
        previousRadioSender = sender;
        
        // TEST DB SONG - Vlad you can un-comment this to see how it works :P
        // Date - get the current date and time
//        let currentDateTime = Date();
//
//        // Put song
//        Song.createSongWith(name: radioLbl.text!, band: radioUrl, category: "maybe", favorite: false, timeRecognize: currentDateTime);
//
//        // Get song
//        let obj = DBUtil.fetchedResultsHistoryController();
//        let songArr = obj.fetchedObjects!; // Array of all songs
//
//        // Initialize the date formatter and set the style
//        let formatter = DateFormatter();
//        formatter.dateFormat = "dd/M/yy HH:mm";
//
//        let formatterLong = DateFormatter();
//        formatterLong.dateStyle = .long;
//        formatterLong.timeStyle = .long;
//
//        // Show song
//        for song in songArr {
//            let printThis = song.name! + " " + song.band! + " " + formatter.string(from: song.time_recog!) + " " + formatterLong.string(from: song.time_recog!);
//            print(printThis);
//        }
        
        
    }
    
}

