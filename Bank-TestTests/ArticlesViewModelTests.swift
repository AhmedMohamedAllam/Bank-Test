//
//  ArticleViewModelTests.swift
//  Bank-TestTests
//
//  Created by Ahmed Allam on 31/12/2021.
//

import Foundation
import XCTest
import Combine

@testable import Bank_Test

final class ArticleViewModelTests: XCTestCase {
	private var subject: ArticlesListViewModel!
	private var mockArticlesService: MockArticlesService!
	private var cancellables: Set<AnyCancellable> = []
	
	override func setUp() {
		super.setUp()
		
		mockArticlesService = MockArticlesService()
		subject = ArticlesListViewModel(articlesService: mockArticlesService)
	}
	
	override func tearDown() {
		cancellables.forEach { $0.cancel() }
		cancellables.removeAll()
		mockArticlesService = nil
		subject = nil
		
		super.tearDown()
	}
	
	func test_fetchArticles_shouldCallService() {
		// when
		subject.fetchArticles()
		
		// then
		XCTAssertEqual(mockArticlesService.getCallsCount, 1)
	}
	
	
	
	func test_fetchArticles_givenServiceCallSucceeds_shouldUpdatePlayers() {
		// given
		mockArticlesService.getResult = .success(Constants.articles)
		
		// when
		subject.fetchArticles()
		
		// then
		XCTAssertEqual(mockArticlesService.getCallsCount, 1)
		subject.$articles
			.sink { XCTAssertEqual($0, Constants.articles) }
			.store(in: &cancellables)
		
		subject.$state
			.sink { XCTAssertEqual($0, .finishedLoading) }
			.store(in: &cancellables)
	}
	
	func test_fetchArticles_givenServiceCallFails_shouldUpdateStateWithError() {
		// given
		mockArticlesService.getResult = .failure(CustomError.testError)
		
		// when
		subject.fetchArticles()
		
		// then
		XCTAssertEqual(mockArticlesService.getCallsCount, 1)
		subject.$articles
			.sink { XCTAssert($0.isEmpty) }
			.store(in: &cancellables)
		
		subject.$state
			.sink { XCTAssertEqual($0, .error(CustomError.testError.localizedDescription))}
			.store(in: &cancellables)
	}
}

// MARK: - Helpers

extension ArticleViewModelTests {
	enum Constants {
		static let articles = [
			Article(id: 1, url: "", source: "", publishedDate: "", updated: "", adxKeywords: "", title: "Article 1", abstract: "", media: []),
			Article(id: 2, url: "", source: "", publishedDate: "", updated: "", adxKeywords: "", title: "Article 2", abstract: "", media: [])
		]
	}
}

enum CustomError: Error, LocalizedError{
	case testError
	
	var errorDescription: String? {
		switch self {
		case .testError: return "Test Error"
		}
	}
}
