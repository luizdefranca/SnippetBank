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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


}
