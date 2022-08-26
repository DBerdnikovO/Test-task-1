//
//  CustomTabItem.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case home
    case play
    case favorite
    case profile
}
 
extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .home:
            return VideoController()
        case .profile:
            return  MainTabBarController(item: .favorite)
        case .play:
            return PlayViewController()
        case .favorite:
            return MainTabBarController(item: .profile)
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .play:
            return UIImage(systemName: "play.circle")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .home:
            return UIImage(systemName: "house.fill")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person.crop.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .play:
            return UIImage(systemName: "play.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .favorite:
            return UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        case .home:
            return UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}

