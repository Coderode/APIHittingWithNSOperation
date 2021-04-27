//
//  HomeRestManager.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 23/04/21.
//

import Foundation
import Moya
class HomeRestManger:NSObject {
    private let userId : String = "b3dc96fa-6b2c-40ed-bd73-21112634e15e"
    static let apiProvider = MoyaProvider<CollectionAPI>()
    static let shared = HomeRestManger()
    func getRailStructure(handler: ((Result<RailStructure,Error>) -> Void)?){
        HomeRestManger.apiProvider.request(.gethomeRails) { (response) in
            switch  response {
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(RailStructure.self, from: response.data)
                    if response.statusCode == 200 {
                        handler?(.success(data))
                    }
                }catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getCollectiondata(page: Int, pageSize: Int, collectionName:  String, handler: ((Result<CollectionResponse,Error>) -> Void)?){
        HomeRestManger.apiProvider.request(.getCollections(collectionName: collectionName, page: page, pageSize: pageSize)) { (response) in
            switch response {
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(CollectionResponse.self, from: response.data)
                    if response.statusCode == 200 {
                        handler?(.success(data))
                    }
                }catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getPromotionData(promoName : String, handler: ((Result<PromotionResponse,Error>) -> Void)?){
        HomeRestManger.apiProvider.request(.getPromos(promoName: promoName)) { (response) in
            switch response {
            
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(PromotionResponse.self, from: response.data)
                    if response.statusCode == 200 {
                        handler?(.success(data))
                    }
                }catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getInprogressData(page : Int, pageSize: Int, handler: ((Result<InprogressResponse,Error>) -> Void)?){
        HomeRestManger.apiProvider.request(.getInprogress(userId: self.userId, page: page, pageSize: pageSize)) { (response) in
            switch response {
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(InprogressResponse.self, from: response.data)
                    if response.statusCode == 200 {
                        handler?(.success(data))
                    }
                }catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getRecommendationsData(page : Int, pageSize: Int, handler: ((Result<RecommendationResponse,Error>) -> Void)?){
        HomeRestManger.apiProvider.request(.getRecommendations(userId: self.userId, page: page, pageSize: pageSize)) { (response) in
            switch response{
            case .success(let response):
                do{
                    let data = try JSONDecoder().decode(RecommendationResponse.self, from: response.data)
                    if response.statusCode == 200 {
                        handler?(.success(data))
                    }
                }catch let error{
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }

}
    
   
