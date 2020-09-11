//
//  Response.swift
//  COVID19
//
//  Created by Charity Hsu on 8/27/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import Foundation

struct Response: Codable {
    
    struct GlobalData: Codable {
        let NewConfirmed: Int
        let TotalConfirmed: Int
        let NewDeaths: Int
        let TotalDeaths: Int
        let NewRecovered: Int
        let TotalRecovered: Int
    }
    
    struct CountryData: Codable {
        let Country: String
        let CountryCode: String
        let NewConfirmed: Int
        let TotalConfirmed: Int
        let NewDeaths: Int
        let TotalDeaths: Int
    }
    
    let Global: GlobalData
    let Countries: [CountryData]
    let Date: String
}
