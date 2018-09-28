//
//  ViewController.swift
//  MyTest
//
//  Created by Vladi on 8/22/18.
//  Copyright © 2018 Vladi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // Here add categories and in each one add the name of the radio
    private let stationDicArr = [
        "HeavyMetal":
            ["Met al Metal"],
        "Jazz":
            ["Jazzi"],
        
        
    ]
    
    // Name of the radios, needs to be the same as the one in stationDicArr
    private let radioDic = [
        "Met al Metal":"http://stream.laut.fm/metal-fm-com",
        "Jazzi":"http://streaming.radio.co/s774887f7b/listen"
    ]
    
    var stationDicArrKeyCopy : [String] = [];
    
    private var player : AVPlayer?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationDicArrKeyCopy = Array(stationDicArr.keys);
  
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

