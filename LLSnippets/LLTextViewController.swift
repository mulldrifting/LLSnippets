//
//  LLTextViewController.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import UIKit

class LLTextViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var copyButton: UIBarButtonItem!
    @IBOutlet weak var pasteButton: UIBarButtonItem!
    
    let pasteboard = UIPasteboard.generalPasteboard()

    override func viewDidLoad() {
        super.viewDidLoad()

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

