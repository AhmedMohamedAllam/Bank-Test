//
//  StoryBoards.swift
//  Bank-Test
//
//  Created by Ahmed Allam on 01/01/2022.
//

import UIKit

enum Storyboards: String{
	case Main

	func instantiateRootViewController() -> UIViewController?{
		return UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController()
	}
	
	func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T?{
		let identifier = String(describing: type.self)
		return UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T
	}
}
