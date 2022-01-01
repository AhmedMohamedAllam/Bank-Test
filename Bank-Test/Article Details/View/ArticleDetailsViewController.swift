//
//  ArticleDetailsViewController.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import Foundation
import UIKit

class ArticlesDetailsViewController: UIViewController{
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var urlLabel: UILabel!
	@IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!

	private var tapGesture: UITapGestureRecognizer!
	
	var viewModel: ArticleViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupURLTapGesture()
		setupUI()
	}
	
	private func setupURLTapGesture(){
		tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapURL))
		urlLabel.addGestureRecognizer(tapGesture)
	}
	
	@objc
	private func didTapURL(){
		if let url = URL(string: viewModel.articleURL ?? ""), UIApplication.shared.canOpenURL(url){
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
	
	private func setupUI(){
		titleLabel.text = viewModel.title
		subtitleLabel.text = viewModel.subtitle
		urlLabel.text = viewModel.articleURL
		imageView.loadImage(string: viewModel.imageURL, placeholder: nil, completion: nil)
		imageHeightConstraint.constant = viewModel.articleImageHeight(viewWidth: imageView.frame.width)
	}
}
