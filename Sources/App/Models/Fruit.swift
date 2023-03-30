//
//  Fruit.swift
//  
//
//  Created by Mike Bastian on 27.02.23.
//

import Fluent
import Vapor

final class Fruit: Model, Content {
    
    static let schema = "fruits"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "image")
    var image: String

    @Field(key: "description")
    var description: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, image: String, description: String) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
    }
}
