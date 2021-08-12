//
//  UiViewCon+Ext.swift
//  Union Play
//
//  Created by samer on 11/06/2021.
//

import UIKit

extension UIViewController {
    
    func presentError(_ err: (SMSError) , message:String , buttonText: String) {
        let actionSheet = UIAlertController(title: message, message: err.rawValue, preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: buttonText, style: .cancel))
        DispatchQueue.main.async { self.present(actionSheet, animated: true) }
    }
    
    func setupTabBarAtt(imageSysName: String, selectedTintColor: UIColor, titleX: String) {
        
        tabBarItem.image = UIImage(systemName: imageSysName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))?.withRenderingMode(.alwaysOriginal).withTintColor(.init(white: 1, alpha: 0.6))
        tabBarItem.selectedImage = UIImage(systemName: imageSysName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))?.withRenderingMode(.alwaysOriginal).withTintColor(selectedTintColor)
        title = titleX
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedTintColor ], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.6)], for: .normal)
    }
    
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title

    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
      }
     }
}


enum SMSError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}
