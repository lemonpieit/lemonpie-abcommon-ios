//
//  UIViewController+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit.UIViewController

public extension UIViewController {
    
    /// Removes back button item string.
    func removeBackButtonString() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Hides back button item.
    func removeBackButton() {
        navigationItem.hidesBackButton = true
    }
    
    /// Set the navigation bar background and title.
    /// - Parameter title: The navigation bar title.
    /// - Parameter color: The navigation bar background color.
    func configureWhiteNavigationBar(withTitle title: String, backgroundColor color: UIColor) {
        navigationItem.title = title
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = color
    }
    
    /// Creates a header view with a label.
    /// - Parameters:
    ///   - title: The text of the label.
    ///   - font: The font of the label.
    ///   - textColor: The color of the text of the label.
    func configureHeaderView(with title: String, font: UIFont, textColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = title
        label.font = font
        label.textColor = textColor
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 7).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        view.addSubview(label)
        
        return view
    }
}
