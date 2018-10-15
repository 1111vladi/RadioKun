//
//  ResultController.swift
//  RadioKun
//
//  Created by Vladi on 10/7/18.
//  Copyright © 2018 olym.yin. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
 
    
    @IBOutlet weak var lyricsText: UITextView!
//    @IBOutlet weak var lyricsLabel: UILabel!
    @IBOutlet weak var bandLabel: UILabel!{
        didSet{
            bandLabel?.text = bandName;
            bandLabel.font = UIFont(name: "Arial-BoldItalicMT", size: 36);
            bandLabel.makeOutLine(oulineColor: UIColor.black, foregroundColor: UIColor.white)
        }
    }
    
    
    @IBOutlet weak var songLabel: UILabel!{
        didSet{
            songLabel?.text = songName;
            songLabel.font = UIFont(name: "Arial-BoldItalicMT", size: 28);
            songLabel.makeOutLine(oulineColor: UIColor.black, foregroundColor: UIColor.white)
        }
    }

    public var lyricsName = "";
    public var bandName = "";
    public var songName = "";
    public var genreName = "";
    
    
    // Theme manager to manage all colors type of each section
    let theme = ThemeManager.currentTheme();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = theme.backgroundColor;
        self.lyricsText.backgroundColor = theme.backgroundColor;
        lyricsText.font = UIFont(name: "ArialRoundedMTBold", size: 16);
        lyricsText.textColor = UIColor.white;
        self.lyricsText?.text = lyricsName;
        
    
    
    }



}
extension UILabel{
    // Stroke effect
    func makeOutLine(oulineColor: UIColor, foregroundColor: UIColor) {
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : oulineColor,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : self.font
            ] as [NSAttributedString.Key : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
    // UnderLine effect
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString);   attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
}
