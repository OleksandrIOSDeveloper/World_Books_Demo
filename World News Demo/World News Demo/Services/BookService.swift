//
//  NetworkService.swift
//  World News Demo
//
//  Created by Александр Родителев on 22.11.2023.
//

import Foundation


class BooksService {
    
    var networkManager = NetworkManager()
    var page: Int = 0
    var listsArray: [List] = []
    var booksArray: [Book] = []
    var nameList: String = ""

    func switchPage(isNext: Bool, completion: () -> Void) {
        if isNext {
            if page < listsArray.count - 1 { // Последняя страница имеет индекс listsArray.count - 1
                page += 1
            }  else {
                page = 0
            }
        } else {
            if page > 0 {
                page -= 1
            }  else {
                page = listsArray.count - 1
            }
        }
        self.nameList = self.listsArray[page].listName
        self.booksArray = self.listsArray[page].books
        completion()
    }
    
    func fetchBooks(completion: @escaping (Error?) -> Void) {
        networkManager.fetchData { result in
            switch result {
            case .success(let response):
                self.listsArray = response.results.lists
                self.booksArray = self.listsArray[self.page].books
                self.nameList = self.listsArray.first?.listName ?? ""
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
   
}
