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
    let bestsellersDate, publishedDate, publishedDateDescription, previousPublishedDate: String
    let nextPublishedDate: String
    let lists: [List]

    enum CodingKeys: String, CodingKey {
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case previousPublishedDate = "previous_published_date"
        case nextPublishedDate = "next_published_date"
        case lists
    }
}

// MARK: - List
struct List: Codable {
    let listID: Int
    let listName, listNameEncoded, displayName: String
    let updated: Updated
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case listID = "list_id"
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case displayName = "display_name"
        case updated
        case books
    }
}

// MARK: - Book
struct Book: Codable {
    let ageGroup: String
    let amazonProductURL: String
    let articleChapterLink, author: String
    let bookImage: String?
    let bookReviewLink: String
    let bookURI, contributor, contributorNote, createdDate: String
    let description, firstChapterLink, price, primaryIsbn10: String
    let primaryIsbn13, publisher: String
    let rank, rankLastWeek: Int
    let sundayReviewLink: String
    let title, updatedDate: String
    let weeksOnList: Int
    let buyLinks: [BuyLink]

    enum CodingKeys: String, CodingKey {
        case ageGroup = "age_group"
        case amazonProductURL = "amazon_product_url"
        case articleChapterLink = "article_chapter_link"
        case author
        case bookImage = "book_image"
      
        case bookReviewLink = "book_review_link"
        case bookURI = "book_uri"
        case contributor
        case contributorNote = "contributor_note"
        case createdDate = "created_date"
        case description
        case firstChapterLink = "first_chapter_link"
        case price
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher, rank
        case rankLastWeek = "rank_last_week"
        case sundayReviewLink = "sunday_review_link"
        case title
        case updatedDate = "updated_date"
        case weeksOnList = "weeks_on_list"
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

enum Updated: String, Codable {
    case monthly = "MONTHLY"
    case weekly = "WEEKLY"
}


