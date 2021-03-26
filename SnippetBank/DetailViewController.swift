//
//  DetailViewController.swift
//  SnippetBank
//
//  Created by Luiz on 3/25/21.
//

import UIKit
import Sourceful


class DetailViewController: UIViewController {

    @IBOutlet weak var syntaxTextView: SyntaxTextView!

    let lexer = SwiftLexer()

    override func viewDidLoad() {
        super.viewDidLoad()

        syntaxTextView.theme = sourceCodeTheme
        syntaxTextView.delegate = self

        // Attach a toolbar with common key symbols to make typing easier.
        syntaxTextView.contentTextView.inputAccessoryView = UIView.editingToolbar(target: self,
                                                                                  action: #selector(insertCharacter))
    }

    

    var snippet: Snippet? {
        didSet {
            refreshUI()
        }
    }

    private func refreshUI() {
        loadViewIfNeeded()
        title = snippet?.name ?? "New Snippet"
        syntaxTextView.text = snippet?.content ?? ""
    }
    var sourceCodeTheme: SourceCodeTheme {
           if UIApplication.activeTraitCollection.userInterfaceStyle == .dark {
               return DarkTheme()
           } else {
               return LightTheme()
           }
       }


       /// Called when the user taps a key symbol in our input accessory view.
       @objc func insertCharacter(_ sender: UIBarButtonItem) {
           guard let value = UnicodeScalar(sender.tag) else { return }
           let string = String(value)
        syntaxTextView.insertText(string)
           UIDevice.current.playInputClick()
       }


}

extension DetailViewController: SnnipetSelectionDelegate {
    func snnipetSelected(_ newSnippet: Snippet) {
        snippet = newSnippet
    }
}

extension DetailViewController: SyntaxTextViewDelegate {
    /// Send back our Swift lexer for this source code.
    func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
}
