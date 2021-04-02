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
        print("adding ...")
        let alert = UIAlertController(title: "New Snippet", message: "Type the name of new snippet", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "New Snippet\(self.snippets.count)"
        }

        let addAction = UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force
            let snippetName = textField?.text ?? "New Snippet\(self.snippets.count)"

            let snippet = Snippet(name: snippetName, content: "")
            self.snippets.append(snippet)
            self.tableView.reloadData()

            print("Text field: \(textField?.text)")
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)

        self.present(alert, animated: true, completion: nil)



    }

}
