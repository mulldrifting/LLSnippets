//
//  LLTextViewController.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import UIKit

class LLTextViewController: UIViewController {
    var snippetName : String = ""
    var snippetText : String = ""
    var snippet : Snippet = Snippet()
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var copyButton: UIBarButtonItem!
    @IBOutlet private weak var pasteButton: UIBarButtonItem!
    
    private let pasteboard = UIPasteboard.generalPasteboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = snippetName
        textView.text = ""
    }

    @IBAction func copyTapped(sender: AnyObject) {
        pasteboard.string = textView.text
    }
    
    @IBAction func pasteTapped(sender: AnyObject) {
        if let pasteString = pasteboard.string {
            
            let currentText = textView.text
            var addedText = ""
            
            if currentText.characters.count > 0 {
                addedText.appendContentsOf("\n\n")
            }
            
            let trimmedString = pasteString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            addedText.appendContentsOf("<< " + trimmedString + " >>")

            textView.text = currentText + addedText
        }
    }
}

