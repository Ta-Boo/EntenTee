//
//  Request.swift
//  Ententee
//
//  Created by hladek on 14/06/2021.
//

import Foundation


extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }

            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }

            result(.success((response, data)))
        }
    }
}

class API {

    static let shared = API()
    let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")
    lazy var decoder = JSONDecoder()

    enum Endpoints: String {
        case users
    }

    enum SovaError: Error {
        case decoding
        case passed(Error)
    }
    //MARK: Private layer
    private init() {}
    private func fetchData<T: Decodable>(from url: URL, callback: @escaping (Result<T, SovaError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] (result) in
            #if DEBUG
            usleep(1_000_000)
            #endif
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                callback(.failure(.passed(error)))
            case .success(( _, let data)):
                print(String(decoding: data, as: UTF8.self))
                do {
                    let result = try self.decoder.decode(T.self, from: data)
                    callback(.success(result))
                } catch let errorDebug {
                    print(errorDebug)
                    callback(.failure(.decoding))
                }
                break
            }
        }.resume()
    }

    //MARK: Protected layer
    func fetchUsers(_ callback: @escaping (Result<[User], SovaError>) -> Void) {
        guard let url = baseUrl?.appendingPathComponent(Endpoints.users.rawValue) else {return}
        fetchData(from: url, callback: callback)
    }
}
