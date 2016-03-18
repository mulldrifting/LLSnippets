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
    
    func updateSnippet(snippet : Snippet) {
        let reverseIndex = (count - 1) - snippet.index
        snippets[reverseIndex] = snippet
        saveSnippetsToUserDefaults()
    }
    
    func addNewSnippet() {
        let newSnippet = Snippet(index: count, name: "New Snippet", text: "")
        snippets.insert(newSnippet, atIndex: 0)
        saveSnippetsToUserDefaults()
    }
    
    private func extractSnippetsFromUserDefaults() {
        if let list = userDefaults.objectForKey(userDefaultsSnippetListKey) as? [ Dictionary<String, String> ] {
            
            for dict in list {
                if let name = dict["name"], text = dict["text"], indexString = dict["index"], isNewString = dict["isNew"] {
                    let isNew = isNewString == "true" ? true : false
                    if let index = Int(indexString) {
                        let newSnippet = Snippet(index: index, name: name, text: text)
                        newSnippet.isNew = isNew
                        snippets.append(newSnippet)
                    }
                }
            }
        }
        else {
            createAndSaveInitialSnippets()
        }
        
        sortSnippets()
    }
    
    private func createAndSaveInitialSnippets() {
        let firstSnippet = Snippet(index: 0, name: "New Snippet", text: "")
        snippets.append(firstSnippet)
        saveSnippetsToUserDefaults()
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
            newDict["isNew"] = snippet.isNew ? "true" : "false"
            list.append(newDict)
        }
        
        userDefaults.setObject(list, forKey: userDefaultsSnippetListKey)
        userDefaults.synchronize()
    }
}