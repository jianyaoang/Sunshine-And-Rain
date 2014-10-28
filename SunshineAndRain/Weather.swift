//
//  Weather.swift
//  SunshineAndRain
//
//  Created by Jian Yao Ang on 10/28/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

import Foundation

struct Weather {
    
    var temperature: Int?
    var summary: String?
    
    init(){
        self.temperature = 0
        self.summary = ""
    }
}