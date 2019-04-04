//
//  MyTabBarItem.swift
//  Sport
//
//  Created by Amir on 4/4/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class MyTabBarItem: UITabBarItem {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Shabnam-FD", size: 14)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}
