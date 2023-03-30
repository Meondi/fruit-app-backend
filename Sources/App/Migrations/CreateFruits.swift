//
//  CreateFruits.swift
//  
//
//  Created by Mike Bastian on 27.02.23.
//

import Fluent

struct CreateFruits: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("fruits")
            .id()
            .field("name", .string, .required)
            .field("image", .string, .required)
            .field("description", .string, .required)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("fruits").delete()
    }
}
