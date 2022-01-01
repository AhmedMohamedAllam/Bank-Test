//
//  ViewController.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 31/12/2021.
//

import UIKit
import Combine

class ArticlesViewController: UIViewController{

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	private let refreshControl = UIRefreshControl()
	private lazy var viewModel = ArticlesListViewModel()
	private var bindings = Set<AnyCancellable>()


	override func viewDidLoad() {
		super.viewDidLoad()
		setupRefreshControl()
		setupTableView()
		bindViewModelToView()
		fetchData()
	}

	private func setupRefreshControl(){
		refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
	}

	@objc
	private func refresh(_ sender: AnyObject) {
		fetchData()
		refreshControl.endRefreshing()
	}

	private func fetchData(){
		viewModel.fetchArticles()
	}

	func bindViewModelToView() {
		viewModel.$articles
			.receive(on: RunLoop.main)
			.sink(receiveValue: { [weak self] _ in
				self?.reloadData()
			})
			.store(in: &bindings)
		
		let stateValueHandler: (ArticlesViewModelState) -> Void = { [weak self] state in
			switch state {
			case .startedLoading:
				self?.startLoading()
			case .finishedLoading:
				self?.stopLoading()
			case .error(let error):
				self?.showError(message: error)
			}
		}
		
		viewModel.$state
			.receive(on: RunLoop.main)
			.sink(receiveValue: stateValueHandler)
			.store(in: &bindings)
	}
	
	private func showArticleDetails(_ article: Article){
		if let detailsVC = Storyboards.Main.instantiateViewController(ArticlesDetailsViewController.self)
			{
			detailsVC.viewModel = ArticleViewModel(article: article)
			navigationController?.show(detailsVC, sender: nil)
		}
	}
}


extension ArticlesViewController {
	func showError(message: String?) {
		displayMessage(title: "Something went wrong!", message: message)
	}

	func startLoading() {
		activityIndicator.startAnimating()
	}

	func stopLoading() {
		activityIndicator.stopAnimating()
	}

	func reloadData() {
		tableView.reloadData()
	}

}

//MARK: - TableView Setup
extension ArticlesViewController{

	private func setupTableView(){
		registerListCellNib()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.refreshControl = refreshControl
	}

	private func registerListCellNib(){
		let nib = UINib(nibName: Constants.articlesTableViewCell, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: Constants.articlesTableViewCell)
	}
}

//MARK: - TableView Delegate
extension ArticlesViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let article = viewModel.articles[indexPath.row]
		showArticleDetails(article)
	}
	
}

extension ArticlesViewController: UITableViewDataSource{

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.articles.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.articlesTableViewCell, for: indexPath) as? ArticlesTableViewCell else {
			return UITableViewCell()
		}
		let article = viewModel.articles[indexPath.row]
		cell.viewModel = ArticleViewModel(article: article)
		return cell
	}

}


