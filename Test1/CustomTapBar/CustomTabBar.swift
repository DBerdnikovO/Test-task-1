//
//  CustomTabBar.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class CustomTabBar: UIStackView {
    
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    
    private lazy var customItemViews: [CustomItemView] = [homeItem, playItem,  favoriteItem, profileItem]
    
    private let homeItem = CustomItemView(with: .home, index: 0)
    private let playItem = CustomItemView(with: .play, index: 1)
    private let profileItem = CustomItemView(with: .profile, index: 2)
    private let favoriteItem = CustomItemView(with: .favorite, index: 3)
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupProperties()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addArrangedSubviews([homeItem, playItem,favoriteItem, profileItem])
    }
    
    private func setupProperties() {
        distribution = .fillEqually
        alignment = .center
        
        backgroundColor = .systemRed
        setupCornerRadius(45)
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
    
    //MARK: - Bindings
    
    private func bind() {
        homeItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.homeItem.animateClick {
                    self.selectItem(index: self.homeItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        playItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.playItem.animateClick {
                    self.selectItem(index: self.playItem.index)
                }
            }
            .disposed(by: disposeBag)
        
        favoriteItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.favoriteItem.animateClick {
                    self.selectItem(index: self.favoriteItem.index)
                }
            }
            .disposed(by: disposeBag)

        
        profileItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.profileItem.animateClick {
                    self.selectItem(index: self.profileItem.index)
                }
            }
            .disposed(by: disposeBag)
        
    }
}
