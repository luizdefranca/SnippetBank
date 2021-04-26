//
//  TableViewController.swift
//  SnippetBank
//
//  Created by Luiz on 4/2/21.
//

import UIKit

// MARK: - Protocol
protocol TagSelectionDelegate: AnyObject {
    func tagSelected(_ tag: Tag)
}


class TagViewController: UITableViewController {

    //MARK: - Proprieties

    let tags = Tag.allCases
    var selectedTag : Tag = Tag.java

    weak var delegate: TagSelectionDelegate?

    //MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tags"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = tags[indexPath.row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTag = tags[indexPath.row]
        guard let supplementary = splitViewController?.viewController(for: .supplementary) as? SnippetTableViewController else { return }
        supplementary.tagSelected(selectedTag)
        splitViewController?.show(.supplementary)
    }

}

//MARK: - Extensions
extension TagViewController: TagSelectionDelegate {
    func tagSelected(_ tag: Tag) {
        
    }
}


