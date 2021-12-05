//
//  Created by user on 27.02.2021.
//

import Foundation

protocol EndPointType {
    var httpMethod: String { get }
    var headers: [String: Any]? { get }
    var url: URL { get }
}

enum RequestItemsType {
    
     case getUser
     case updateUser
     case getChatList
     case getChat(id: Int)
     case patchChat(id: Int)
     case removeChat(id: Int)

    static func createRequst(type: EndPointType, parameters: [String: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: type.url)
        request.httpMethod = type.httpMethod
        type.headers?.forEach({ (key, value) in
            request.addValue(value as! String, forHTTPHeaderField: key)
        })
        if let parameters = parameters {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            if let data = jsonData{
                request.httpBody = data
            }
        }
     
        return request
    }
}

extension RequestItemsType: EndPointType {

    var httpMethod: String {
        switch self {
        case .getUser, .getChatList, .getChat:
            return "GET"
        case .updateUser, .patchChat:
            return "PATCH"
        case .removeChat:
            return "DELETE"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getUser, .getChatList, .getChat, .removeChat:
            return nil
        case .updateUser, .patchChat:
            return ["Content-Type": "application/json"]
        }
    }
    
    var url: URL {
        switch self {
        
        case .getUser:
            return URL(string: "http://localhost:3000/user")!
        case .updateUser:
            return URL(string: "http://localhost:3000/user")!
        case .getChatList:
            return URL(string: "http://localhost:3000/chats")!
        case .getChat(let id), .removeChat(let id), .patchChat(let id):
            return URL(string: "http://localhost:3000/chats/\(id)")!
        }
    }
    
}

