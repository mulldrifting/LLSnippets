//
//  LLTextViewController.swift
//  LLSnippets
//
//  Created by Lauren Lee on 3/17/16.
//  Copyright © 2016 Lauren Lee. All rights reserved.
//

import UIKit

protocol LLTextViewControllerDelegate {
    func snippetChanged(snippet : Snippet)
}

class LLTextViewController: UIViewController {
    var snippet : Snippet = Snippet()
    var delegate : LLTextViewControllerDelegate?
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var copyButton: UIBarButtonItem!
    @IBOutlet private weak var pasteButton: UIBarButtonItem!
    
    private let pasteboard = UIPasteboard.generalPasteboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = ""
        textView.delegate = self
        textView.text = snippet.text
        updateTitle()
    }

    @IBAction func copyTapped(sender: AnyObject) {
        pasteboard.string = textView.text
    }
    
    @IBAction func pasteTapped(sender: AnyObject) {
        if let pasteString = pasteboard.string {
            
            let currentText = textView.text
            var addedText = ""
            let trimmedString = pasteString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            if currentText.characters.count > 0 {
                addedText.appendContentsOf("\n\n")
            }
            else if snippet.isNew {
                let range = Range<String.Index>(start: trimmedString.startIndex, end: trimmedString.startIndex.advancedBy(15, limit: trimmedString.endIndex))
                snippet.name = trimmedString.substringWithRange(range)
                updateTitle()
            }
            
            addedText.appendContentsOf("<< " + trimmedString + " >>")

            textView.text = currentText + addedText
            textChanged(textView.text)
        }
    }
    
    private func updateTitle() {
        navigationItem.title = snippet.name
    }
    
    private func textChanged(newText : String ) {
        if snippet.isNew {
            snippet.isNew = false
            snippet.wasChangedForFirstTime = true
        }
        snippet.text = newText
        delegate?.snippetChanged(snippet)
    }
}

extension LLTextViewController : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        let text = textView.text
//        if snippet.isNew {
//            let range = Range<String.Index>(start: text.startIndex, end: text.startIndex.advancedBy(15, limit: text.endIndex))
//            snippet.name = text.substringWithRange(range)
//            updateTitle()
//        }
        textChanged(text)
    }
}

