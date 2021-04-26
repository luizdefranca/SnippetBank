//
//  DetailViewController.swift
//  SnippetBank
//
//  Created by Luiz on 3/25/21.
//

import UIKit
import Sourceful


class DetailViewController: UIViewController {

    //MARK: - Proprieties

    let swiftLexer = SwiftLexer()
    let pythonLexer = Python3Lexer()
    var snippet: Snippet? {
        didSet {
            refreshUI()
        }
    }

    var sourceCodeTheme: SourceCodeTheme {
        if UIApplication.activeTraitCollection.userInterfaceStyle == .dark {
            return DarkTheme()
        } else {
            return LightTheme()
        }
    }

    //MARK: - Outlets

    @IBOutlet weak var syntaxTextView: SyntaxTextView!
    @IBOutlet weak var languageLabel: UILabel!

    //MARK: - Lifecicle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syntaxTextView.theme = sourceCodeTheme
        syntaxTextView.delegate = self
        
        syntaxTextView.contentTextView.inputAccessoryView
            = UIView.editingToolbar(target: self, action: #selector(insertCharacter))

        setupMenuBar()
        lexerForSource("swift")
    }
    
    //MARK: Setup Functions
    private func setupMenuBar(){
        
        let swiftMenuitem = UIAction(title: "Swift", image: UIImage(named: "swift")
                                     , handler: { (_) in
            self.lexerForSource("swift")
            self.languageLabel.text = "Swift"
        })
        
        let pythonMenuItem = UIAction(title: "Python", image: UIImage(named: "python")
                                      , handler: { (_) in
            self.lexerForSource("python")
            self.languageLabel.text = "Python"
            
        })

        var menu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [pythonMenuItem, swiftMenuitem])
        }
        let barButtonItem = UIBarButtonItem(title: "Language", image: nil, primaryAction: nil, menu: menu)
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }

    private func refreshUI() {
        loadViewIfNeeded()
        title = snippet?.name ?? "New Snippet"
        syntaxTextView.text = snippet?.content ?? ""
    }

    @objc func insertCharacter(_ sender: UIBarButtonItem) {
        guard let value = UnicodeScalar(sender.tag) else { return }
        let string = String(value)
        syntaxTextView.insertText(string)
        UIDevice.current.playInputClick()
    }
}


//MARK: - Extensions
extension DetailViewController: SnnipetSelectionDelegate {
    func snnipetSelected(_ selectedSnippet: Snippet) {
        snippet = selectedSnippet
    }
}

extension DetailViewController: SyntaxTextViewDelegate {
    func lexerForSource(_ source: String) -> Lexer {
        if source == "swift" {
            return swiftLexer
        } else {
            return pythonLexer
        }
    }
}
