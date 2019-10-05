//
//  NetworkServiceError.swift
//  
//
//  Created by Melvin John on 06/09/2019.
//

import Foundation

/// Common Network service error
enum NetworkServiceError: Error {

    /// No Connection Error
    case noConnection
    
    /// Unable to build a URL Type
    case couldNotBuildURL(URLPath: String)
    
    /// HTTP Error
    case HTTPError(type: HTTPURLResponse.ResponseType)
    
    /// Failed to Parse Fruit API Response.
    case unableToParseData
        
}
