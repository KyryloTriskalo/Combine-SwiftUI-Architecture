//
//  Created by user on 27.02.2021.
//

import Foundation
import Combine
import Resolver

struct UserService {
    
    @Injected private var client: HTTPClient
  
    func getProfile(endPoint: EndPointType) -> AnyPublisher<User, Error> {
        let request = RequestItemsType.createRequst(type: endPoint)
        return client.perform(request)
                      .map(\.value)
                      .eraseToAnyPublisher()
    }

    func postProfile(endPoint: EndPointType, data: User) -> AnyPublisher<User, Error> {
        return Just(data)
                .encode(encoder: JSONEncoder())
                .mapError { error -> APIError in
                    return APIError.encodingError(error.localizedDescription)
                }
                .tryMap { jsonData -> [String: Any] in
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        guard let jsonDict =  json as? [String: Any] else { throw APIError.encodingError("Invalid object") }
                        return jsonDict
                    } catch {
                        throw APIError.encodingError(error.localizedDescription)
                    }
                }
                .map { jsonDict -> URLRequest in
                    let request = RequestItemsType.createRequst(type: endPoint, parameters: jsonDict)
                    return request
                }
                .flatMap { request in
                    return self.client.perform(request)
                        .map(\.value)
                }
                .eraseToAnyPublisher()
        }

    }

