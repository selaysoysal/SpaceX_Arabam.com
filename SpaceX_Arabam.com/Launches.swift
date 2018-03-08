//
//  Launches.swift
//  SpaceX_Arabam.com
//
//  Created by Selay Soysal on 3.03.2018.
//  Copyright © 2018 Selay Turkmen. All rights reserved.
//

import UIKit
struct Launches: Decodable {
    var flight_number:Int?
    var launch_year:String?
    var launch_date_utc:String?
    var rocket:Rocket?
    var launch_site: Launch_Site?
    var launch_success:Bool?
    var links:Links?
    var details: String?
    
    private enum CodingKeys: String, CodingKey {
        case flight_number
        case launch_year
        case launch_date_utc
        case rocket
        case launch_site
        case launch_success
        case links
        case details
    }
}
