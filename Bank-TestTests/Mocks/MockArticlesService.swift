//
//  MockArticlesService.swift
//  Bank-TestTests
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation
import Combine

@testable import Bank_Test

final class MockArticlesService: ArticlesServiceProtocol {
	var getCallsCount: Int = 0
	
	var getResult: Result<[Article], Error> = .success([])
	
	func getArticles() -> AnyPublisher<[Article], Error>{
		getCallsCount += 1
		
		return getResult.publisher.eraseToAnyPublisher()
	}
}
