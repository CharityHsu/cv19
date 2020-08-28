//
//  CountryData.swift
//  COVID19
//
//  Created by Charity Hsu on 8/27/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import Foundation

struct CountryData: Codable {
    let Country: String
    let CountryCode: String
    let TotalConfirmed: Int
    let TotalDeaths: Int
}
