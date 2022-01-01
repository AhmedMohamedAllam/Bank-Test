//
//  ArticleCellViewModel.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import UIKit
import Combine

class ArticleViewModel{
	@Published var title: String = ""
	@Published var subtitle: String = ""
	@Published var imageURL: String? = nil
	@Published var articleURL: String? = nil

	private let article: Article
	
	init(article: Article) {
		self.article = article
		setUpBindings()
	}
	
	private func setUpBindings() {
		title = article.title
		subtitle = article.abstract
		imageURL = getImageURL()
		articleURL = article.url
	}
	
	private func getImageURL() -> String?{
		let imageMetadata = article.media.first?.mediaMetadata.first(where: {$0.format == .mediumThreeByTwo440})
		return imageMetadata?.url
	}
	
	
	//get image height to render the image constraints successfully
	func articleImageHeight(viewWidth: CGFloat) -> CGFloat{
		let imageSize = getImageSize()
		guard imageSize.height > 0 else {
			return 0
		}
		return (imageSize.height * viewWidth) / imageSize.width
	}
	
	//image size from Article
	private func getImageSize() -> CGSize{
		let imageMetadata = article.media.first?.mediaMetadata.first(where: {$0.format == .mediumThreeByTwo440})
		return CGSize(width: imageMetadata?.width ?? 0, height: imageMetadata?.height ?? 0)
	}
	
}
