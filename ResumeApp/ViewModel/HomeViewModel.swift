//
//  HomeViewModel.swift
//  ResumeApp
//
//  Created by Satish Birajdar on 2019-07-10.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var candidateDetail: [Biodata]
    
    // Initialization with dependency for future dependency injection
    init(candidDetail: [Biodata]) {
        self.candidateDetail = candidDetail
    }
}
