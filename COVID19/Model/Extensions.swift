//
//  Extensions.swift
//  COVID19
//
//  Created by Charity Hsu on 8/25/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import Foundation

extension Int {
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
}
