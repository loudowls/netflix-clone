//
//  AuthErrors.swift
//  netflix-clone
//
//  Created by Pardip Bhatti on 29/12/25.
//

import Foundation


enum AuthErrors: Error {
    case supbaseErrors(Error)
    case unkonwnUserID
    case invalidURL
    case invalidResponse
    case invalidJSON
    
    var sbError: String {
        switch self {
        case .supbaseErrors(let error):
            return "\(error.localizedDescription)"
        case .unkonwnUserID:
            return "User not found"
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidJSON:
            return "Invalid JSON"
        }
    }
}
