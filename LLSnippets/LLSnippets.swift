//
//  Snippets.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import Foundation

class Snippets : NSObject {
    let userDefaultsSnippetListKey = "userDefaultsSnippetListKey"
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var snippets : [ Snippet ] = []
    var count : Int {
        return snippets.count
    }
    
    override init() {
        super.init()
        extractSnippetsFromUserDefaults()
    }
    
    func snippetAtIndex(index: Int) -> Snippet {
        return snippets[index]
    }
    
    private func extractSnippetsFromUserDefaults() {
        if let list = userDefaults.objectForKey(userDefaultsSnippetListKey) as? [ Dictionary<String, String> ] {
            for dict in list {
                if let name = dict["name"], text = dict["name"], index = dict["index"] {
                    if let index = Int(index) {
                        let newSnippet = Snippet(index: index, name: name, text: text)
                        snippets.append(newSnippet)
                    }
                }
            }
        }
        sortSnippets()
    }
    
    private func sortSnippets() {
        snippets = snippets.sort({ $0.index > $1.index })
    }
    
    private func saveSnippetsToUserDefaults() {
        var list : [ Dictionary<String, String> ] = []
        for snippet in snippets {
            var newDict : Dictionary<String, String> = [:]
            newDict["index"] = "\(snippet.index)"
            newDict["name"] = snippet.name
            newDict["text"] = snippet.text
            list.append(newDict)
        }
        
        userDefaults.setObject(list, forKey: userDefaultsSnippetListKey)
    }
}