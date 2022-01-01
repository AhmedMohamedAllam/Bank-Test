//
//  UIImageView+Extension.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import UIKit
import Kingfisher

extension UIImageView {
	
	@discardableResult
	func loadImage(string: String?, placeholder: UIImage?, completion: (() -> Void)? = nil) -> DownloadTask? {
		let url = URL(string: string ?? "")
		return loadImage(url: url, placeholder: placeholder, completion: completion)
	}
	
	@discardableResult
	func loadImage(url: URL?, placeholder: UIImage?, completion: (() -> Void)? = nil) -> DownloadTask? {
		self.kf.indicatorType = .activity
		let task = self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1))], progressBlock: nil) { (result) in
			completion?()
		}
		return task
	}
	
}
