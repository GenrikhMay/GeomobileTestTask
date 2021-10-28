//
//  NetworkError.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 28.10.2021.
//

import Foundation

enum NetworkError: Error {
    case unableToDecode
    case dataFailure
    case badURL
    case unknown
}
