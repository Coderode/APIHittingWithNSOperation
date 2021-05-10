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
    static var accesstoken : String = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjA2NTA2MDIsImlhdCI6MTYyMDY0OTQwMiwianRpIjoiNDNiODMwZGYtZTk0MS00Mjc4LTliYWEtYzhlZmJlNGYyN2UwIiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiMzgwYjNkY2EtYzM0Mi00Nzk0LTk2YjYtMDQ4ODdhNjQxOWViIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiZGl2ZXkgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6ImRpdmV5QHNuaXAuY29tIiwiZ2l2ZW5fbmFtZSI6ImRpdmV5IiwidXNlcmlkIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJkaXZleUBzbmlwLmNvbSJ9.MeK_hGjqkGmAf7MsH8bygRONz2uabpDKuYm28ckipP_qMvAomFyrNSxcB-Fc86lY8yymm0Uc34iGrH-fkGiKs1ioQqGCaiEHqvkhpWzOkKnJMiuB_-vMlpjV8qs7T61UR3EhMHO4U9ggp-CZ24RGuN2eQEw13alayi2pdzJOELErXqfCRpEtEQZIlmLdxydvcQSNFAZkIfGLvZD6YwrciwnjufA6gEboefbu0K93jCxHcnvR22zLe5_NVM4Xq06JpoTbtW1H8URXmNmunlNf9eRbq8Y-Obm7oOmjKbc5_tBHC_NmEqtnRRPY-nazBFsiqnwC6WHM7sGwzObXKTjHBQ"
}
