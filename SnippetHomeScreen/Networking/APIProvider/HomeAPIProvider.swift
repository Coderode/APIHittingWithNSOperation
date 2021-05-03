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
    static var accesstoken : String = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjAwNDk0ODksImlhdCI6MTYyMDA0ODI4OSwianRpIjoiZjFkZjEzNTUtMTk0YS00MjdlLTkyZjctNjkyNzkyZDkwODVjIiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiZDhiMGIzMzgtOGM5Ny00YjRlLWIyZWQtYzU3MmI4MzllNWE4IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiZGl2ZXkgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6ImRpdmV5QHNuaXAuY29tIiwiZ2l2ZW5fbmFtZSI6ImRpdmV5IiwidXNlcmlkIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJkaXZleUBzbmlwLmNvbSJ9.EKrYDw-OWM9dXYFpA6HkO3z60P3wZFHLpF1P1jP8KAE525TTt3qWa711VgZmoekeSg8Nl91qN0A5hf2dO1zBcNr9J_tu5XOwHoQizjVJ7UZ_iMZmSK9c47s7M33HN0SdqFQxrZPhTw8dPZwZnGCjqz24VeVLfmy7a1pCh0c8bOj70KZNGB38wgLvJsPgtTVoDJ1mWgSEB5-92xEbcJ5weXGcGC30ZDE6QU2BAVxLEoK-mJW6rRlFTO9fzd3YV2RfzXnUWacwdYT37ZKM8Ivfksj0WBCMK6vmBVzO81I0m2ZLEJCS9Yr6DK9_1i-1I7ubtGlgkFSoqurE-5d67eAcmg"
}
