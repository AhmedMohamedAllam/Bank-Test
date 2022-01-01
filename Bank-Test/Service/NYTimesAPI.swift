//
//  NYTimesAPI.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation
import Moya

enum NYTimesAPI{
	case mostPopularArticles
}

extension NYTimesAPI: TargetType{
	var baseURL: URL { URL(string: "https://api.nytimes.com")! }
	
	var path: String {
		switch self {
		case .mostPopularArticles:
			return "/svc/mostpopular/v2/viewed/1.json"
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .mostPopularArticles:
			return .get
		}
	}
	
	var task: Task {
		switch self {
		case .mostPopularArticles:
			return .requestParameters(parameters: ["api-key": Constants.apiKey], encoding: URLEncoding.queryString)
		}
	}
	
	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}
}
