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
    static var accesstoken : String = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MTk1MDYyMTEsImlhdCI6MTYxOTUwNTMxMSwianRpIjoiOGM2YjU0NDQtZWM0ZC00ZDZmLWE4MmYtYTE3ZTRiYmFkMjliIiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiYjNkYzk2ZmEtNmIyYy00MGVkLWJkNzMtMjExMTI2MzRlMTVlIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiMjYxNmE0ZGItNjAyMC00YmFhLTk0ZGItZGNiYjQwYTRjN2QxIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiRGlrc2hhIFNhd2FybiIsInByZWZlcnJlZF91c2VybmFtZSI6InRlc3RAc25pcHBldC5jb20iLCJnaXZlbl9uYW1lIjoiRGlrc2hhIiwidXNlcmlkIjoiYjNkYzk2ZmEtNmIyYy00MGVkLWJkNzMtMjExMTI2MzRlMTVlIiwiZmFtaWx5X25hbWUiOiJTYXdhcm4iLCJlbWFpbCI6InRlc3RAc25pcHBldC5jb20ifQ.cI6dmGnZYAQ_4sb9HbbqG_FwiqDNN10JMynhkVNFat1L454HB5QqG3nd4aoNp5NBsuKCAC2IO5wHKKOvUtak6HP-KN1fmQT42GVder-wl1VDI6BnjsAR_k2iBmGojCYyusJCinEj1C6-m6Gk9uEDI9VWu_hccc55J54XPqzzp4-NT0F74RLAUaq8Nki0fLd5n9BlsAXWbn-O4D3-yEhM-U5bDj_Rt7dT-Sfm-Lu9bp1CB6yFPmfbiCd9mL5OKU5mVF4iXv5Rphd-7pp73N5PCsbPfWGSy4jEcgdLDaTfR_lg2bdS7CsVcitq5zOQpAGeQEPy817HmowX94aj8fpzFQ"
}
