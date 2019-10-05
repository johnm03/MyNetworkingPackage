//
//  NetworkService.swift
//  
//
//  Created by Melvin John on 06/09/2019.
//

import Combine
import Foundation

internal struct NetworkService {
    func dataTaskPublisher<T: Decodable>(withURL url: URL) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError(mapError)
                .eraseToAnyPublisher()
    }
    
    private func mapError(error: Error) -> Error {
        if error._code == NSURLErrorTimedOut && error._code == NSURLErrorNotConnectedToInternet {
            return NetworkServiceError.noConnection
        }
        
        return NetworkServiceError.unableToParseData
       
    }
}
