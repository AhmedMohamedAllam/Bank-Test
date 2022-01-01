//
//  ArticlesTableViewCell.swift
//  CarTask
//
//  Created by Ahmed Allam on 15/12/2021.
//

import UIKit
import Kingfisher

class ArticlesTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var containerView: UIView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var subTitleLabel: UILabel!
	@IBOutlet private weak var articleImageView: UIImageView!
	@IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
	
	private var downloadImageTask: DownloadTask?
	
	var viewModel: ArticleViewModel!{
		didSet{setupUI()}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		//		downloadImageTask?.cancel()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		updateShadow()
	}
	
	//Add card shadow for the view
	private func updateShadow(){
		containerView.layer.cornerRadius = 10
		articleImageView.layer.cornerRadius = 10
		containerView.layer.shadowColor = UIColor.gray.cgColor
		containerView.layer.shadowOffset = CGSize.zero
		containerView.layer.shadowRadius = 7
		containerView.layer.shadowOpacity = 0.4
	}
	
	func setupUI(){
		titleLabel.text = viewModel.title
		downloadImageTask = articleImageView.loadImage(string: viewModel.imageURL, placeholder: nil, completion: nil)
		imageHeightConstraint.constant = viewModel.articleImageHeight(viewWidth: articleImageView.frame.width)
		subTitleLabel.text = viewModel.subtitle
		subTitleLabel.isHidden = imageHeightConstraint.constant > 0
	}
	
	
	
}
