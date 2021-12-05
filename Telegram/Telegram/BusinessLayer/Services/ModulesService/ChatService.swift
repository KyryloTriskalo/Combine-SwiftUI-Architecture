//
//  ChatService.swift
//  Telegram
//
//  Created by Kyrylo Triskalo on 15.08.2021.
//

import Foundation

import Combine
import Resolver

class ChatService {
    
    @Injected private var client: HTTPClient
    
    
    var changesCount: Int = 0 
  
    func getChatList(endPoint: EndPointType) -> AnyPublisher<[Chat], Error> {
        let request = RequestItemsType.createRequst(type: endPoint)
        return client.perform(request)
                      .map(\.value)
                      .eraseToAnyPublisher()
    }
    
    func getChat(endPoint: EndPointType) -> AnyPublisher<Chat, Error> {
        let request = RequestItemsType.createRequst(type: endPoint)
        return client.perform(request)
                      .map(\.value)
                      .eraseToAnyPublisher()
    }
    
    func removeChat(endPoint: EndPointType) -> AnyPublisher<Chat?, Error> {
        let request = RequestItemsType.createRequst(type: endPoint)
        return client.perform(request)
                      .map(\.value)
                      .eraseToAnyPublisher()
    }
    
    func postChat(endPoint: EndPointType, data: Chat) -> AnyPublisher<Chat, Error> {
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
