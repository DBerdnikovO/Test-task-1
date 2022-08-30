//
//  FavoriteViewController.swift
//  Test1
//
//  Created by Данила Бердников on 27.08.2022.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    var getCast: [Cast] = []
    
    var request: [NSManagedObject] = []

    
    enum Section: Int, CaseIterable {
        case  favorit
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Cast>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getCount()
        getUserData()
        setupCollectionView()
        createDataSource()
        reloadData()
        
       
        
        view.backgroundColor = .red
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//       getCount()
        print("I APPEAR")
        getUserData()
       // print(getCast.)
        reloadData()
    }
    
    func getUserData() {
        getCast = FavoritsDelegate.shared.loadUserData()
        reloadData()
    }
    
//    func getCount() {
//        getCast = FavoritsDelegate.shared.getCast()
//        self.reloadData()
//    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundColor()
        
        view.addSubview(collectionView)
        
        collectionView.register(FavoritsCells.self, forCellWithReuseIdentifier: FavoritsCells.reusedId)
        collectionView.delegate = self
    }
    
    private func reloadData() {
        getCast = FavoritsDelegate.shared.loadUserData()
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cast>()
        
        snapshot.appendSections([.favorit])
     //   print(FavoritsDelegate.shared.loadUserData())
        snapshot.appendItems(getCast, toSection: .favorit)
    

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}
extension FavoriteViewController: UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let title = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        
        
        guard let section = Section(rawValue: indexPath.section) else {return }
        
        switch section {
        case .favorit:
            let titleInfo = MovieDescriptionViewController(title: title.title!)
            titleInfo.modalPresentationStyle = .fullScreen
               present(titleInfo, animated: true)
        }
        
    }
}

extension FavoriteViewController {
    

    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Cast>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, title)-> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .favorit:
                return self.configure(collectionView: collectionView, cellType: FavoritsCells.self, with: title, for: indexPath)
            }
        })

    }
}

extension FavoriteViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .favorit:
                
                return self.movieSection()
            }
        }
        return layout
    }
    
    private func movieSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(145))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        return section
    }
}
