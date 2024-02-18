//
//  NetworkManager.swift
//  World News Demo
//
//  Created by Александр Родителев on 22.11.2023.
//

import Foundation
import Alamofire

typealias NetworkError = AFError

class NetworkManager {
    
    private let baseUrl = "https://api.nytimes.com/svc/books/v3/lists/full-overview.json"
    private let parameters = ["api-key": "G7mqEMfFQdUjeyjTupI76JAmrwSDSggn"]

    func fetchData(completion: @escaping (Result<BooksResponse, Error>) -> Void) {
        AF.request(baseUrl, method: .get, parameters: parameters).validate().responseDecodable(of: BooksResponse.self) { response in
            switch response.result {
            case .success(let booksResponse):
                completion(.success(booksResponse))
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
                print("Request failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
}
