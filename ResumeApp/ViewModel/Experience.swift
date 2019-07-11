//
//  Experience.swift
//  ResumeApp
//
//  Created by Satish Birajdar on 2019-07-11.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

struct Experience : Codable {
    var companyName: String
    var role: String
    var from: String
    var to: String
    var responsibilities: [String]
    var achievements: String
}
