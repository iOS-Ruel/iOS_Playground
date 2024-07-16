//
//  Entry.swift
//
//
//  Created by Chung Wussup on 7/16/24.
//

import Vapor


struct Entity:  Content {
    var id: UUID?
    var title: String
    var content: String
    
    init(id: UUID? = nil , title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
    
}
