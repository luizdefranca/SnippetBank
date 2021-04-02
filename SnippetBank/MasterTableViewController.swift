//
//  MasterTableViewController.swift
//  SnippetBank
//
//  Created by Luiz on 3/25/21.
//

import UIKit
import Sourceful


protocol SnnipetSelectionDelegate: AnyObject {
    func snnipetSelected(_ newSnippet: Snippet)
}

class MasterTableViewController: UITableViewController {

    weak var delegate: SnnipetSelectionDelegate?

    var snippets: [Snippet] = [
        Snippet(name: "Snippet1", content: "let x = 10"),
        Snippet(name: "Snippet2", content: "let y = true"),
        Snippet(name: "Snippet3", content: "let z = \"abc\" ")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSnippet))
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snippets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let snippet = snippets[row]
        cell.textLabel?.text = snippet.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets[indexPath.row]
        delegate?.snnipetSelected(selectedSnippet)
        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }

    @objc func addSnippet(){

    }

}
