//
//  FortuneService.swift
//  Fortune Cookie Monster
//
//  Created by Jonathan Rothwell on 04/06/2018.
//  Copyright © 2018 Zuhlke UK. All rights reserved.
//

import Foundation
import Security

struct FortuneService {
    var fortunes: [String]
    init() {
        guard let fortuneFile = Bundle.main.path(forResource: "fortunes", ofType: "txt"),
            let content = try? String(contentsOfFile: fortuneFile, encoding: .utf8) else {
                fatalError("Couldn't load fortunes! 🥠🚫")
        }
        fortunes = content.split(separator: "%").map(String.init)
    }
    
    func getFortune(withSeed seed: Double) -> String {
        srand48(Int(seed * Date().timeIntervalSince1970))

        let rand = Int(drand48() * (Double(fortunes.count - 1)))
        
        return fortunes[rand]
    }
}
