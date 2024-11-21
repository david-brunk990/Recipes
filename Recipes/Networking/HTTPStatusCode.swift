//
//  HTTPStatusCode.swift
//
//  Created by DJ A on 8/16/24.
//

import Foundation

enum HTTPStatusCode {
    init?(rawValue: Int) {
        switch rawValue {
        case 100...199:
            self = .info
        case 200...299:
            self = .success
        case 300...399:
            self = .redirect
        case 400...499:
            self = .clientError
        case 500...599:
            self = .serverError
        default:
            self = .unknown
        }
    }
    
    case info
    case success
    case redirect
    case clientError
    case serverError
    case unknown
}
