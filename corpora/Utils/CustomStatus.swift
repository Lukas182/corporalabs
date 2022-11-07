//
//  CustomStatus.swift
//  corpora
//
//  Created by David Ortego Lucas on 7/11/22.
//

import Foundation
enum CustomStatus {
    case Vivo, Muerto, Desconocido, Cualquiera
}

extension CustomStatus: LocalizedError {
    public var customDescription: String? {
        switch self {
        case .Vivo: return "alive"
        case .Muerto: return "dead"
        case .Desconocido: return "unknown"
        case .Cualquiera: return ""
        }
    }

}
