//
//  Response.swift
//  COVID19
//
//  Created by Charity Hsu on 8/27/20.
//  Copyright © 2020 Charity Hsu. All rights reserved.
//

import Foundation

struct Response: Codable {
    let Global: GlobalData
    let Countries: [CountryData]
    let Date: String
}
