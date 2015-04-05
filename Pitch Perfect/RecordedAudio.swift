//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Peter Sun on 4/1/15.
//  Copyright (c) 2015 Psun. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    
    var filePathUrl: NSURL!
    var title: String!
    

    override init() {
        self.filePathUrl = nil
        self.title = ""
    }

    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}