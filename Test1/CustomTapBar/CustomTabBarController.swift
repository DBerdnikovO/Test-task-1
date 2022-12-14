//
//  CustomTabBarViewController.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit
import RxSwift
import SnapKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
        view.layoutIfNeeded()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = false
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(self.action(sender:)))
//        
//    }
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
    
    private func setupHierarchy() {
        view.addSubview(customTabBar)
    }
    
    private func setupLayout() {
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
            $0.height.equalTo(90)
        }
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.addShadow()
        
        selectedIndex = 0
        let controllers = CustomTabItem.allCases.map { $0.viewController }
        
        setViewControllers(controllers, animated: true)
    }

    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        customTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
}
