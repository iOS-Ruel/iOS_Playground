//
//  Entry.swift
//
//
//  Created by Chung Wussup on 7/16/24.
//

import Vapor
import Fluent

final class Entity: Model, Content {
    static let schema: String = "entries"
    
    init() {}
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "Title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    init(id: UUID? = nil , title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
    
}

extension Entity: @unchecked Sendable {}
