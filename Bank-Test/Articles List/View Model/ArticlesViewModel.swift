//
//  MainViewModel.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation
import Combine
import Moya

enum ArticlesViewModelState {
	case startedLoading
	case finishedLoading
	case error(String)
}

class ArticlesViewModel{
	@Published private(set) var articles: [Article] = []
	@Published private(set) var state: ArticlesViewModelState = .startedLoading
	private let articlesService: ArticlesServiceProtocol

	private var bindings = Set<AnyCancellable>()
	
	init(articlesService: ArticlesServiceProtocol = ArticlesService()) {
		self.articlesService = articlesService
	}
	
}


extension ArticlesViewModel {
	func fetchArticles() {
		state = .startedLoading
		
		let receiveCompletionHandler: (Subscribers.Completion<MoyaError>) -> Void = { [weak self] completion in
			switch completion {
			case .failure:
				self?.state = .error("Cannot fetch Articles")
			case .finished:
				self?.state = .finishedLoading
			}
		}
		
		let valueHandler: ([Article]) -> Void = { [weak self] articles in
			self?.articles = articles
		}
		
		articlesService
			.getArticles()
			.sink(receiveCompletion: receiveCompletionHandler, receiveValue: valueHandler)
			.store(in: &bindings)
	}
}
