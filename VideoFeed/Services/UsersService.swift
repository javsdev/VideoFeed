//
//  UsersService.swift
//  VideoFeed
//
//  Created by Javier Ramirez on 21/09/21.
//

import Foundation

protocol UsersService {
    func fetchUser(byUsername username: String,
                   completion: (Result<User, ServiceError>) -> Void)
}

enum ServiceError: Error {
    case jsonLoadingError
    case jsonParsingError
}

class MockUsersService: UsersService {
    private let jsonFilename = "user"
    static let shared = MockUsersService()
    func fetchUser(byUsername username: String, completion: (Result<User, ServiceError>) -> Void) {
        guard let bundlePath = Bundle.main.path(forResource: jsonFilename,
                                                ofType: "json"),
              let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) else {
            return completion(.failure(.jsonLoadingError))
        }
        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            completion(.success(user))
        } catch {
            completion(.failure(.jsonParsingError))
        }
    }
}
