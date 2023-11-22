//
//  NetworkService.swift
//  World News Demo
//
//  Created by Александр Родителев on 22.11.2023.
//

import Foundation


class BooksService {
    
    var networkManager = NetworkManager()
    var page = 1
    var listsArray: [List] = []
    var booksArray: [Book] = []
    
    func switchPage(isNext: Bool, completion: () -> Void) {
        if isNext {
            page += 1
        } else {
            page -= 1
        }
      completion()
       
    }
    
    
    func fetchBooks(completion: @escaping (Error?) -> Void) {
        networkManager.fetchData { result in
            switch result {
            case .success(let response):
                self.listsArray = response.results.lists
                self.booksArray = self.listsArray[self.page].books
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
