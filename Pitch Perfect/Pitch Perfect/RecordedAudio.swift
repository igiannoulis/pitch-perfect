//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Hlias Giannoulis on 3/22/15.
//  Copyright (c) 2015 Hlias Giannoulis. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject

{
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }

}