//
//  CustomError.swift
//  corpora
//
//  Created by David Ortego Lucas on 5/11/22.
//

import Foundation
enum CustomError {
    case noConnection, noData, failedRequest
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return "Opssss! no data"
        case .noConnection: return "No Internet Connection"
        case .failedRequest: return "Opssss! We got a failure!!"
        }
    }

}
