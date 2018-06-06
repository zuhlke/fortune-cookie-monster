//
//  ViewController.swift
//  Fortune Cookie Monster
//
//  Created by Jonathan Rothwell on 04/06/2018.
//  Copyright © 2018 Zuhlke UK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let motion = MotionService()
    let fortune = FortuneService()
    var timer: Timer?

    @IBOutlet weak var fortuneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if motion == nil {
            fortuneLabel.text = "No motion available! 😱"
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionBegan(_ motionType: UIEventSubtype, with event: UIEvent?) {
        if motionType == .motionShake {
            self.motion?.beginRecordingMotion()
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake,
            let seed = self.motion?.stopRecordingMotion() {
            fortuneLabel.attributedText = formatString(fortune.getFortune(withSeed: seed))
        }
    }
    
    private func formatString(_ fortune: String) -> NSAttributedString {
        let string = NSMutableAttributedString()
        
        string.append(NSAttributedString(string: fortune,
                                         attributes: [.font: UIFont.boldSystemFont(ofSize: 24.0)]))
        string.append(NSAttributedString(string: "\n\n"))
        string.append(NSAttributedString(string: "Shake me again for a new fortune...",
                                         attributes: [.font: UIFont.italicSystemFont(ofSize: 12.0)]))
        return string
    }
}

