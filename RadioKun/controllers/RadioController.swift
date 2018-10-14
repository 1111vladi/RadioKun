//
//  ViewController.swift
//  MyTest
//
//  Created by Vladi on 8/22/18.
//  Copyright © 2018 Vladi. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie

class RadioController: UIViewController, UITableViewDataSource{
    

    
            
        
    
    
    
    
    
    // Record Animation
//    var animation = LOTAnimationView(name: "record");
    
    // Apikey for Lyrics
    private let apikey = "Tk7IikwaoN12CkCV1wocicLSsWntNT5e3DvGPidvtKk63kK4iakesZNc6smFVfDc";
    
    // Global UIAlert
    private var alert : UIAlertController? = nil;
    private var alert2 : UIAlertController? = nil;
    // Song scan variables
    var _start = false
    var _client: ACRCloudRecognition?
    
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
        
//        animation.frame = CGRect(x: -35, y: 40, width: 75, height: 75);
//        animation.contentMode = .scaleAspectFill;
//        animation.loopAnimation = true;
//        view.addSubview(animation);
//        animation.play();
        
        // Recognition stuff
        // ----- START -----
        _start = false;
        let config = ACRCloudConfig();
        
        config.accessKey = "f75f02f3d1e63df9d623dec82494a62a";
        config.accessSecret = "Skmt3sSm8D9FgLLMPPguRIrhcXezPuB8bt1iCW34";
        config.host = "identify-eu-west-1.acrcloud.com";
        //if you want to identify your offline db, set the recMode to "rec_mode_local"
        config.recMode = rec_mode_remote;
        config.audioType = "recording";
        config.requestTimeout = 10;
        config.protocol = "http";
        config.keepPlaying = 2;  //1 is restore the previous Audio Category when stop recording. 2 (default), only stop recording, do nothing with the Audio Category.
        
        /* used for local model */
        if (config.recMode == rec_mode_local || config.recMode == rec_mode_both) {
            config.homedir = Bundle.main.resourcePath!.appending("/acrcloud_local_db");
        }
        
        // Result
        config.resultBlock = {[weak self] result, resType in
            self?.handleResult(result!, resType:resType);
        }
        self._client = ACRCloudRecognition(config: config);
        // ----- END -----
        
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
            "Please No":["Don't Click Here!!!"]
            
        ];
       
        radioDic = [
            "Don't Click Here!!!":"https://https://youtu.be/x6bbqy3ef8I",
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
    
        // TEST - Dummy data
//        // Date - get the current date and time
//        let currentDateTime = Date();
//        // Put song
//        Song.createSongWith(name: "Nick", band: "Crushers", category: "toBad", favorite: false, timeRecognize: currentDateTime, lyric: "Non");
    }
    
    // Result Handler
    func handleResult(_ result: String, resType: ACRCloudResultType) -> Void
    {
        
        DispatchQueue.main.async {
            //            self.resultView.text = result;
            let data: Data? = result.data(using: .utf8) // non-nil
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) else{return}
            guard let jsonObject = json as? [String: Any] else {
                return
            }
            guard let status = jsonObject["status"] as? [String: Any] else {
                return
            }
            guard let msg = status["msg"] as? String else {
                return
            }
            print(result) // delectus aut autem
        
            if msg == "Success" {
                guard let metadata = jsonObject["metadata"] as? [String: Any] else{
                    return
                }
                guard let music = metadata["music"] as? [[String: Any]] else {
                    return
                }
                
                // Band Name
                guard let artists = music[0]["artists"] as? [[String: Any]] else {
                    return
                }
                guard let name = artists[0]["name"] as? String else {
                    return
                }
                
                // Genre Name
                guard let genres = music[0]["genres"] as? [[String: Any]] else{
                    return
                }
                guard let genreName = genres[0]["name"] as? String else {
                    return
                }
                print(genreName);
                
                // Song Name
                guard let title = music[0]["title"] as? String else {
                    return
                }
                
                let lyric = self.findLyrics(title, name);
                
                // To move to the next Controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil);
                let resultController = storyboard.instantiateViewController(withIdentifier: "ResultController") as! ResultController;
                resultController.bandName = name;
                resultController.songName = title;
                resultController.lyricsName = lyric;
                // This is the RecognitionController constant variable that is used for navigation
                self.navigationController?.pushViewController(resultController, animated: true);
                self.alert?.dismiss(animated: true, completion: nil);
                
                // Date - get the current date and time
                let currentDateTime = Date();
                
                // Put song
                Song.createSongWith(name: name, band: title, category: genreName, favorite: false, timeRecognize: currentDateTime, lyric: lyric);
                
            } else {
                self.alert?.dismiss(animated: true, completion: nil);
                self.alert2 = UIAlertController(title: "Song not found", message: "Please try again", preferredStyle: .alert)
                
                self.alert2!.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.stopScan((Any).self);
                }))
                
                self.present(self.alert2!, animated: true, completion: nil)
                print("Oh no!!!")
            }
            self._client?.stopRecordRec();
            self._start = false;
        }
    }
    
    // Find Lyrics Method
//     ----- START -----
    func findLyrics(_ songName: String, _ bandName: String) -> String {
        let apikey = "Tk7IikwaoN12CkCV1wocicLSsWntNT5e3DvGPidvtKk63kK4iakesZNc6smFVfDc";
        
        var currentLyrics = "No Lyrics... =[";
        // Enconde the names of each section so it could be convert to url when there characters which
        // are in the parameters can't be convert to url(e.x: white space can't be convert to so enconding
        // the space change it to %20, which can be convert)
        let songNameEncoded = songName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        let bandNameEncoded = bandName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        // Preparation of url
        let urlString = "https://orion.apiseeds.com/api/music/lyric/\(bandNameEncoded)/\(songNameEncoded)?apikey=\(apikey)";
        let url = URL(string: urlString)!;

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: [])else{return}
            guard let jsonObject = json as? [String: Any] else {
                return
            }
            guard let result = jsonObject["result"] as? [String: Any] else {
                return
            }
            guard let track = result["track"] as? [String: Any] else {
                return
            }
            guard let lyrics = track["text"] as? String else {
                return
            }
            
            currentLyrics = lyrics;
            print(String(data: data, encoding: .utf8)!)
        } // End result scope - EVERYTHING DIIIEEEES

        task.resume();
        return currentLyrics;
    }
    
    // ----- END -----
    
    
    // Table
    // ----- START -----
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
    // ----- END -----
    
    
    @IBAction func scanSongAction(_ sender: Any) {
        songScan((Any).self);
        
        // Open the AlertController
        alert = UIAlertController(title: "Scanning...", message: "", preferredStyle: .alert)
        
        self.alert!.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
            self.stopScan((Any).self);
        }))
        
        //create an activity indicator
        let indicator = UIActivityIndicatorView(frame: alert!.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //add the activity indicator as a subview of the alert controller's view
        alert!.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.color = UIColor.black
        indicator.startAnimating()
        self.present(alert!, animated: true, completion: nil)
        
        print("Amm which song is it..?");
    }
    
    // Start scan
    func songScan(_ state:Any){
        if (_start) {
            return;
        }
        self._client?.startRecordRec();
        self._start = true;
    }
    
    // Stop Scan
    func stopScan(_ sender:Any) {
        self._client?.stopRecordRec()
        self._start = false;
        print("Scan stopped, no song for you")
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
        
//        // Get song
        let obj = DBUtil.fetchedResultsHistoryController();
        let songArr = obj.fetchedObjects!; // Array of all songs

        // Initialize the date formatter and set the style
        let formatter = DateFormatter();
        formatter.dateFormat = "dd/M/yy HH:mm";

        let formatterLong = DateFormatter();
        formatterLong.dateStyle = .long;
        formatterLong.timeStyle = .long;

        // Show song
        for song in songArr {
            let printThis = song.name! + " " + song.band! + " " + formatter.string(from: song.time_recog!) + " " + formatterLong.string(from: song.time_recog!);
            print(printThis);
        }
        
        
    }
    
}

