//
//  MainTabBarController.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let titleLabel = UILabel()
    private let item: CustomTabItem
    
    init(item: CustomTabItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupProperties() {
        titleLabel.configureWith(item.name, color: .black, alignment: .center, size: 28, weight: .bold)
        view.backgroundColor = .white
    }
}


