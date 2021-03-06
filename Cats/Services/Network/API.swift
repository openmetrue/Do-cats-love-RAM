//
//  API.swift
//  Cats
//
//  Created by Mark Khmelnitskii on 10.04.2022.
//

import Foundation
import Combine

enum API {
    static private let agent = Agent()
    static private let base = URL(string: "https://api.thecatapi.com/v1")!
}

extension API {
    static func getAllCats(page: Int, limit: Int) -> AnyPublisher<[Cat], Error> {
        let url = base.appendingPathComponent("/images/search")
        let queryItem = [URLQueryItem(name: "size", value: "small"),
                         URLQueryItem(name: "mime_types", value: "jpg"),
                         URLQueryItem(name: "limit", value: "\(limit)"),
                         URLQueryItem(name: "page", value: "\(page)")]
        return agent.run(url: url, parameters: queryItem)
    }
    static func searchCats(_ query: String) -> AnyPublisher<[Breedes], Error> {
        let url = base.appendingPathComponent("/breeds/search")
        let queryItem = [URLQueryItem(name: "q", value: query)]
        return agent.run(url: url, parameters: queryItem)
    }
    static func getCatsFromID(_ id: String) -> AnyPublisher<Cat, Error> {
        let url = base.appendingPathComponent("images/\(id)")
        return agent.run(url: url)
    }
}
