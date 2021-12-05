//
//  Created by user on 27.02.2021.
//


/*
 How it works:
 
 1) https://nodejs.org/uk/download/ - download node js for your mac
 2) in terminal run ' npm install -g json-server '
 3) in terminal run ' json-server --watch db.json '
 4) copy data from database.json (lay inside the Network Manager folder) and paste it on the db.json file
 5) cmd + s, quit terminal, and repeat step 3 in place where you created db.json file

 
 Additional tutorial
 https://www.youtube.com/watch?v=7vx0RIwHVzg&t=928s
 */

import Foundation
import Combine

enum APIError: Error {
    case encodingError(String?)
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

struct HTTPResponse<T> {
    let value: T
    let response: URLResponse
}

struct HTTPClient {
    let session: URLSession

    func perform<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<HTTPResponse<T>, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap { result -> HTTPResponse<T> in
                let data = try decoder.decode(T.self, from: result.data)
                return HTTPResponse(value: data, response: result.response)
            }
            .eraseToAnyPublisher()
    }
}
