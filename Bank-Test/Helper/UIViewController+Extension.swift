//
//  UIViewController+Extension.swift
//  CarTask
//
//  Created by Ahmed Allam on 16/12/2021.
//

import UIKit

extension UIViewController{
	
	func displayMessage(title: String?, message: String?){
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(okAction)
		present(alertController, animated: true, completion: nil)
	}
}
