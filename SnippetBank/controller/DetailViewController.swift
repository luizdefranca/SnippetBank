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

    let swiftLexer = SwiftLexer()
    let pythonLexer = Python3Lexer()
    @IBOutlet weak var languageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        syntaxTextView.theme = sourceCodeTheme
        syntaxTextView.delegate = self

        // Attach a toolbar with common key symbols to make typing easier.
        syntaxTextView.contentTextView.inputAccessoryView = UIView.editingToolbar(target: self,
                                                                                  action: #selector(insertCharacter))

        setupMenuBar()
        lexerForSource("swift")
    }

    
    private func setupMenuBar(){

        let swiftMenuitem = UIAction(title: "Swift", image: UIImage(named: "swift"), handler: { (_) in
            self.lexerForSource("swift")
            self.languageLabel.text = "Swift"
        })

        let pythonMenuItem = UIAction(title: "Python", image: UIImage(named: "python"), handler: { (_) in
            self.lexerForSource("python")
            self.languageLabel.text = "Python"

        })
        

        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [pythonMenuItem, swiftMenuitem])
        }
        let barButtonItem = UIBarButtonItem(title: "Language", image: nil, primaryAction: nil, menu: menu)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
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
    func snnipetSelected(_ selectedSnippet: Snippet) {
        snippet = selectedSnippet
    }
}

extension DetailViewController: SyntaxTextViewDelegate {
    /// Send back our Swift lexer for this source code.
    func lexerForSource(_ source: String) -> Lexer {
        if source == "swift" {
            return swiftLexer
        } else {
            return pythonLexer
        }
    }

    
}
