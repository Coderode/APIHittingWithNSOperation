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
    static var accesstoken : String = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjAwNDU0NjAsImlhdCI6MTYyMDA0NDI2MCwianRpIjoiMGZjYjY0Y2EtYmFlOS00NzVjLThjMTEtZDlmYjcwNjhlYzhkIiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiM2Q0YWM4ZDktYTcxMy00M2UzLTkyY2EtM2FjNmY3NzI3NjBlIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiZGl2ZXkgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6ImRpdmV5QHNuaXAuY29tIiwiZ2l2ZW5fbmFtZSI6ImRpdmV5IiwidXNlcmlkIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJkaXZleUBzbmlwLmNvbSJ9.Peri10teNx6nP6TTYZYUqqcNEKHXet1sb3FpCcTa7SZDMDXaDXpNoXJaw_9nZ6bImv02asL1vyC52OZW462vV9TcwK2aXDVReumM83ReaiA-NIiTb5DScWMLwmeZ0QGawcrBIMIlsDSWndDe98_mL26Z93q1k-cc3CWEP-pE7aQOnRXHOygvsYyN0cTrWdr8zmT-VxhwYSWQvMVPFX0YnxxzLbtFmIt4IQwZIJv9a-OuClkjiR-M7AEs7YbQBsMOMpPs_ohExQt_amR9Jy-P7_gogHleie63aX4iUniPrN9B9yKxk0psbslXJFasXqianlB6D7LZk7-hCqPWa0aZSQ"
}
