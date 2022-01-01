//
//  ArticlesService.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation
import Combine
import Moya

protocol ArticlesServiceProtocol {
	func getArticles() -> AnyPublisher<[Article], MoyaError>
}

class ArticlesService: ArticlesServiceProtocol {
	var provider: MoyaProvider<NYTimesAPI>
	
	init(provider: MoyaProvider<NYTimesAPI> = MoyaProvider<NYTimesAPI>()){
		self.provider = provider
	}
	
	func getArticles() -> AnyPublisher<[Article], MoyaError> {
		provider.requestPublisher(.mostPopularArticles, callbackQueue: .main)
			.map(ArticleList.self)
			.map({$0.results})
			.eraseToAnyPublisher()
	}
}
