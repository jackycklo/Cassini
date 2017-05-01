//
//  DemoURL.swift
//  Cassini
//
//  Created by Chi kit Lo on 1/5/2017.
//  Copyright © 2017 Chi kit Lo. All rights reserved.
//

import Foundation

struct DemoURL
{
    //static let Stanford = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
    static let Stanford = "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"

    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(_ imageName: String?) -> URL? {
        if let urlstring = NASA[imageName ?? ""] {
            //return NSURL(string: urlstring)
            return URL(string: urlstring)

        } else {
            return nil
        }
    }
}
