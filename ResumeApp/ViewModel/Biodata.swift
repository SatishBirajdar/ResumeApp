//
//  HomeModel.swift
//  ResumeApp
//
//  Created by Satish Birajdar on 2019-07-10.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

struct Biodata: Codable {
    var name: String
    var professionalSummary: String
    var skills: String
    var experiences: [Experience]
    var contactDetails: String
}
