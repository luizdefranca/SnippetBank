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

class SnippetTableViewController: UITableViewController {

    weak var delegate: SnnipetSelectionDelegate?
    var selectedTag : Tag = .persistence

    var snippets: [Snippet] = [
        Snippet(name: "Snippet1", content: "let x = 10", language: .python),
        Snippet(name: "Snippet2", content: "let y = true", language: .python),
        Snippet(name: "Snippet3", content: "let z = \"abc\" ", language: .python, tag: .network)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSnippet(text:)))
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let snippetsByTag = fetchSnippetBy(tag: selectedTag) {
            return snippetsByTag.count
        } else {
            return snippets.count
        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)

        if let snippetBySelectedTag = fetchSnippetBy(tag: self.selectedTag) {
            let snippet = snippetBySelectedTag[row]
            cell.textLabel?.text = snippet.name
        } else {
            let snippet = snippets[row]
            cell.textLabel?.text = snippet.name
        }

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSnippet = snippets[indexPath.row]
        delegate?.snnipetSelected(selectedSnippet)
        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.show(.secondary)
//            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }

    @objc func addSnippet(text: String?){
        print("adding ...")
        let alert = UIAlertController(title: "New Snippet", message: "Type the name of new snippet", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "New Snippet\(self.snippets.count)"
        }

        let addAction = UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force

            if let snippetName = textField?.text {
                let snippet = Snippet(name: snippetName.isEmpty ? "New Snippet \(self.snippets.count)": snippetName, content: "")
                self.snippets.append(snippet)
                self.tableView.reloadData()
                print("Text field: \(textField?.text)")
            } 
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)

        self.present(alert, animated: true, completion: nil)
    }

    func fetchSnippetBy(tag selectedTag : Tag) -> [Snippet]?{
        return snippets.filter{
            snippet in
            snippet.tag == selectedTag
        }
    }
}

extension SnippetTableViewController: TagSelectionDelegate {
    func tagSelected(_ selectedTag: Tag) {
        self.selectedTag = selectedTag
    }
}


