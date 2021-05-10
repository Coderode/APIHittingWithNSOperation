//
//  HomeRestManager.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation
import Moya
class HomeRestManger:NSObject {
    private let userId : String = "045928ba-cc75-481a-b1ee-9f1196917e45"
    static let apiProvider = MoyaProvider<CollectionAPI>()
    static let shared = HomeRestManger()
    func getRailStructure(handler: ((Result<RailStructure,Error>) -> Void)?){
        let apicall = NSOperationAPICaller<CollectionAPI,RailStructure>.init(target: .gethomeRails)
        apicall.responseBlock = { response in
            switch response {
            case .success(let response):
                handler?(.success(response))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getCollectiondata(page: Int, pageSize: Int, collectionName:  String, handler: ((Result<CollectionResponse,Error>) -> Void)?,getAPICaller : ((NSOperationAPICaller<CollectionAPI,CollectionResponse>) -> Void)?){
        let apicall = NSOperationAPICaller<CollectionAPI, CollectionResponse>.init(target: .getCollections(collectionName: collectionName, page: page, pageSize: pageSize))
        getAPICaller?(apicall)
        apicall.responseBlock = { response in
            switch response {
            case .success(let response):
                handler?(.success(response))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getPromotionData(promoName : String, handler: ((Result<PromotionResponse,Error>) -> Void)?,getAPICaller : ((NSOperationAPICaller<CollectionAPI,PromotionResponse>) -> Void)?){
        let apicall = NSOperationAPICaller<CollectionAPI,PromotionResponse>.init(target: .getPromos(promoName: promoName))
        getAPICaller?(apicall)
        apicall.responseBlock = {reponse in
            switch reponse {
            case .success(let response):
                handler?(.success(response))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getInprogressData(page : Int, pageSize: Int, handler: ((Result<InprogressResponse,Error>) -> Void)?,getAPICaller : ((NSOperationAPICaller<CollectionAPI,InprogressResponse>) -> Void)?){
        let apicall = NSOperationAPICaller<CollectionAPI,InprogressResponse>.init(target: .getInprogress(userId: self.userId, page: page, pageSize: pageSize))
        getAPICaller?(apicall)
        apicall.responseBlock = { response in
            switch response {
            case .success(let response):
                handler?(.success(response))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getRecommendationsData(page : Int, pageSize: Int, handler: ((Result<RecommendationResponse,Error>) -> Void)?,getAPICaller : ((NSOperationAPICaller<CollectionAPI,RecommendationResponse>) -> Void)?){
        let apicall = NSOperationAPICaller<CollectionAPI,RecommendationResponse>.init(target: .getRecommendations(userId: self.userId, page: page, pageSize: pageSize))
        getAPICaller?(apicall)
        apicall.responseBlock = { response in
            switch response {
            case .success(let response):
                handler?(.success(response))
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }

}
    
   
