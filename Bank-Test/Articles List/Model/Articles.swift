//
//  Article.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation


// MARK: - Article
struct ArticleList: Codable {
	let results: [Article]
}

// MARK: - Result
struct Article: Codable, Equatable {
	
	
	let id: Int
	let url: String
	let source: String
	let publishedDate: String
	let updated: String
	let adxKeywords: String
	let title, abstract: String
	let media: [Media]
	
	enum CodingKeys: String, CodingKey {
		case url, id, source, media, title, updated, abstract
		case publishedDate = "published_date"
		case adxKeywords = "adx_keywords"
	}
	
	static func == (lhs: Article, rhs: Article) -> Bool {
		lhs.id == rhs.id
	}
	
}

// MARK: - Media
struct Media: Codable {
	let caption: String
	let mediaMetadata: [MediaMetadatum]
	
	enum CodingKeys: String, CodingKey {
		case caption
		case mediaMetadata = "media-metadata"
	}
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
	let url: String
	let format: Format?
	let height, width: Int
}

enum Format: String, Codable {
	case mediumThreeByTwo210 = "mediumThreeByTwo210"
	case mediumThreeByTwo440 = "mediumThreeByTwo440"
	case standardThumbnail = "Standard Thumbnail"
}
