//
//  LLSnippet.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import Foundation

class Snippet : NSObject {
    var index : Int
    var name : String  = ""
    var text : String = ""
    var isNew : Bool = true
    var wasChangedForFirstTime : Bool = false
    
    override init() {
        self.index = 0
        super.init()
    }
    
    init(index: Int, name: String, text: String) {
        self.index = index
        
        super.init()
        
        self.name = name
        self.text = text
    }
}