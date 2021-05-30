//
//  collectionAPIProvider.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import Foundation

import Moya

enum CollectionAPI {
    case gethomeRails
    case getCollections(collectionName : String,page : Int, pageSize : Int)
    case getPromos(promoName: String)
    case getInprogress(userId: String, page: Int, pageSize: Int)
    case getRecommendations(userId: String, page: Int, pageSize: Int)
}

extension CollectionAPI : TargetType {
    var baseURL: URL {
        return URL(string: "http://snippet-alb-testing-422974023.us-east-2.elb.amazonaws.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .gethomeRails:
            return "/rails/home"
        case .getCollections(collectionName : let collectionName,page: _, pageSize: _):
            return "/collections/\(collectionName)"
        case .getPromos(promoName: let promoName):
            return "/promos/\(promoName)"
        case .getInprogress(userId: let userId, page: _, pageSize: _):
            return "/users/\(userId)/inprogress"
        case .getRecommendations(userId: let userId, page: _, pageSize: _):
            return "/users/\(userId)/recommendations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch  self {
        
        case .gethomeRails:
            return .requestPlain
        case .getCollections(collectionName: _, page: let page, pageSize: let pageSize):
            return .requestParameters(parameters: ["page" : page, "psize": pageSize], encoding: URLEncoding.queryString)
        case .getPromos(promoName: _):
            return .requestPlain
        case .getInprogress(userId: _, page: let page, pageSize: let pageSize):
            return .requestParameters(parameters: ["page" : page, "psize": pageSize], encoding: URLEncoding.queryString)
        case .getRecommendations(userId: _, page: let page, pageSize: let pageSize):
            return .requestParameters(parameters: ["page" : page, "psize": pageSize], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization": Token.accesstoken]
    }
}


class Token {
    static var accesstoken : String = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjIzODIwNDksImlhdCI6MTYyMjM4MDg0OSwianRpIjoiNTgwYzY3MmEtNzE0ZS00MjY5LWE0YjctYzc0OWNkODg3YjcwIiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiZjBjM2ZmYWQtMTU3MC00NzI0LTg1ZmYtZjE4ODY3YjZjMjQwIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyIqIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJwcmVtaXVtIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJzbmlwcGV0LWFwaSI6eyJyb2xlcyI6WyJwcmVtaXVtIiwidXNlciJdfSwiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJkaXZleSB0ZXN0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoiZGl2ZXlAc25pcC5jb20iLCJnaXZlbl9uYW1lIjoiZGl2ZXkiLCJ1c2VyaWQiOiIwNDU5MjhiYS1jYzc1LTQ4MWEtYjFlZS05ZjExOTY5MTdlNDUiLCJmYW1pbHlfbmFtZSI6InRlc3QiLCJlbWFpbCI6ImRpdmV5QHNuaXAuY29tIn0.NPA37XPfc2KlnzOyRBxELMQmLUwbnLbQMy8MxdQNrvM5W_zlSN6AchvQVPgFxHrcmBowCzLtg7BDj37fulJHC-7A8RiiukB2ozSDL8lMsL0FQCQ5Cn3aQtSdgsHW5BsVhDVSdzpt39sz1H0WqgtQb6vyWgLB2suL4Gd57gcutM5wcXoTmI8GUZLQZTTmUCVJUim1AZuQ2kFzbF60HHWhWeLM4kQAjR4SPNLQVYC1s-VVVrt0uocGOyHvJsv9Q4KSkoWS8K8iZD9pS-D8jhpVWdRZrrrvBDrGOeDMkS3fsykHqAuo6BS-ghRSxUP7Bhk-H4hLCelzcJFJIU7Evycpjw"
}
