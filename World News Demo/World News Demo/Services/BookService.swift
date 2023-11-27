//
//  NetworkService.swift
//  World News Demo
//
//  Created by Александр Родителев on 22.11.2023.
//

import Foundation


class BooksService {
    
    var networkManager = NetworkManager()
    var page: Int = 1
    var listsArray: [List] = []
    var booksArray: [Book] = []
    
    func switchPage(isNext: Bool, completion: () -> Void) {
        if isNext {
            if page < listsArray.count - 1 {
                self.booksArray = self.listsArray[page].books
                page += 1
            } // else: handle the case when you're already at the last page
        } else {
            if page > 1 {
                page -= 1
                self.booksArray = self.listsArray[page - 1].books
            } // else: handle the case when you're already at the first page
        }
        completion()
    }
    
    func fetchBooks(completion: @escaping (Error?) -> Void) {
        networkManager.fetchData { result in
            switch result {
            case .success(let response):
                self.listsArray = response.results.lists
                self.booksArray = self.listsArray[self.page - 1].books
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
