//
//  FruitController.swift
//  
//
//  Created by Mike Bastian on 27.02.23.
//

import Fluent
import Vapor

struct FruitController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let fruits = routes.grouped("fruits")
        fruits.get(use: index)
        fruits.post(use: create)
        fruits.put(use: update)
        fruits.group(":fruitID") { fruit in
            fruit.delete(use: delete)
        }
    }
    
    // GET Request /fruits route
    func index(req: Request) throws -> EventLoopFuture<[Fruit]> {
        return Fruit.query(on: req.db).all()
    }
    
    // POST Request /fruits route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let fruit = try req.content.decode(Fruit.self)
        return fruit.save(on: req.db).transform(to: .ok)
    }
    
    // PUT Request /fruits route
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let fruit = try req.content.decode(Fruit.self)
        return Fruit.find(fruit.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.name = fruit.name
                $0.image = fruit.image
                $0.description = fruit.description
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // DELETE Request /fruits/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Fruit.find(req.parameters.get("fruitID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
        
    }
}
