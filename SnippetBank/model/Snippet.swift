//
//  Snippet.swift
//  SnippetBank
//
//  Created by Luiz on 3/25/21.
//

import Foundation

struct Snippet {
    var name: String
    var content: String
    var language: Language = .python
    var tag: Tag = .persistence
}
