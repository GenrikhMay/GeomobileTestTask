//
//  NetworkService.swift
//  GeoTestTask
//
//  Created by Mayorov Genrikh on 26.10.2021.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(request: URLRequest) -> Observable<T>
}

enum NetworkError: Error {
    case unableToDecode
    case dataFailure
    case unknown
}

public class NetworkService: NetworkServiceProtocol {
    let session = URLSession(configuration:URLSessionConfiguration.default)

    func fetch<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable.create { observer in
            let task = self.session.dataTask(with: request) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    do {
                        switch statusCode {
                        case 200...399:
                            guard let _data = data
                            else {
                                throw NetworkError.dataFailure
                            }
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(T.self, from:_data)
                            observer.onNext(result)
                        default:
                            observer.onError(NetworkError.unknown)
                        }
                    } catch let error {
                        observer.onError(error)
                    }
                } else {
                    observer.onError(NetworkError.unknown)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
