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
    
    var selectedSnippets: [Snippet] { snippets.filter{(snippet) -> Bool in
        snippet.tag == self.selectedTag
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedTag.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSnippet))
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let snippetsByTag = fetchSnippetsBy(tag: selectedTag) {
            return snippetsByTag.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        if let snippetsBySelectedTag = fetchSnippetsBy(tag: self.selectedTag) {
            let snippet = snippetsBySelectedTag[row]
            cell.textLabel?.text = snippet.name
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedSnippet = snippets[indexPath.row]
        if let snippetsBySelectedTag = fetchSnippetsBy(tag: self.selectedTag) {
            selectedSnippet = snippetsBySelectedTag[indexPath.row]
        }
        
        delegate?.snnipetSelected(selectedSnippet)
        splitViewController?.show(.secondary)
    }
    
    @objc func addSnippet(){
        print("adding ...")
        let alert = UIAlertController(title: "New Snippet", message: "Type the name of new snippet", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "New Snippet\(self.snippets.count)"
        }
        
        let addAction = UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force
            
            if let snippetName = textField?.text {
                let name = snippetName.isEmpty ? "New Snippet \(self.snippets.count)": snippetName
                let snippet = Snippet(name: name, content: "", tag: self.selectedTag)
                self.snippets.append(snippet)
                self.tableView.reloadData()
                print("Text field: \(textField?.text ?? "")")
                self.delegate?.snnipetSelected(snippet)
                self.splitViewController?.show(.secondary)
            } 
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchSnippetsBy(tag selectedTag : Tag) -> [Snippet]?{
        return snippets.filter{
            snippet in
            snippet.tag == selectedTag
        }
    }


    private func refreshUI() {
        loadViewIfNeeded()
        title = selectedTag.rawValue
    }
}

extension SnippetTableViewController: TagSelectionDelegate {
    func tagSelected(_ selectedTag: Tag) {
        self.selectedTag = selectedTag
        refreshUI()
        tableView.reloadData()
    }
}


