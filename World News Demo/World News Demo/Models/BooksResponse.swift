//
//  BooksResponse.swift
//  World News Demo
//
//  Created by Александр Родителев on 22.11.2023.
//

import Foundation

struct BooksResponse: Codable {
    let status, copyright: String
    let numResults: Int
    let results: Results

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Results
struct Results: Codable {
    let lists: [List]
    
    enum CodingKeys: String, CodingKey {
        case lists
    }
}

// MARK: - List
struct List: Codable {
    let listID: Int
    let listName: String
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case listName = "list_name"
        case books
    }
}

// MARK: - Book
struct Book: Codable {
    let author: String
    let bookImage: String?
    let description: String
    let title: String
    let buyLinks: [BuyLink]

    enum CodingKeys: String, CodingKey {
        case author
        case bookImage = "book_image"
        case description
        case title
        case buyLinks = "buy_links"
    }
}

// MARK: - BuyLink
struct BuyLink: Codable {
    let name: Name
    let url: String
}

enum Name: String, Codable {
    case amazon = "Amazon"
    case appleBooks = "Apple Books"
    case barnesAndNoble = "Barnes and Noble"
    case booksAMillion = "Books-A-Million"
    case bookshop = "Bookshop"
    case indieBound = "IndieBound"
    case bookshopOrg = "Bookshop.org"
}


