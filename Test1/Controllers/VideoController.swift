//
//  ViewController.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit
import Kingfisher


class VideoController: UIViewController {
    
    
    
    let viewController = UIViewController()

    private var movies = [Title]()
    
    private var TVs = [Title]()


    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Title>?
    
    enum Section: Int, CaseIterable {
        case  popularFilms, popularTVseries
        
        func description() -> String {
            switch self{
                
            case .popularFilms:
                return "Popular Movie"
            case .popularTVseries:
                return "TV Show"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
        createDataSource()
        reloadData()
        
        APICaller.shared.getTrendingMovies { result in
            switch result {
                
            case .success(let result):
                if result.results.count != 0 {
                    self.movies = result.results
                    
                    self.reloadData()
                }

            case .failure(let error):
                self.showAlert(with: "ERRO", and: error.localizedDescription)
            }
        }
        
        APICaller.shared.getTrendingTVs { result in
            switch result {
                
            case .success(let result):
                if result.results.count != 0 {
                    self.TVs = result.results
                    
                    self.reloadData()
                }

            case .failure(let error):
                self.showAlert(with: "ERRO", and: error.localizedDescription)
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Movve"
        
        super.viewWillAppear(animated)
         let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
            nav?.tintColor = UIColor.white
    }
    
        
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundColor()
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.register(MovieCells.self, forCellWithReuseIdentifier: MovieCells.reusedId)
        collectionView.register(TVCells.self, forCellWithReuseIdentifier: TVCells.reusedId)
        collectionView.delegate = self
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Title>()

        snapshot.appendSections([.popularFilms, .popularTVseries])
        
        snapshot.appendItems(movies, toSection: .popularFilms)
        snapshot.appendItems(TVs, toSection: .popularTVseries)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension VideoController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let title = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        
        guard let section = Section(rawValue: indexPath.section) else {return }
        
        switch section {
        case .popularFilms:
             let titleInfo = TitleViewController(title: title)
            
            self.present(titleInfo, animated: true)
        case .popularTVseries:
            let titleInfo = TitleViewController(title: title)
            
           self.present(titleInfo, animated: true)
        }
        
    }
}


extension VideoController {
    

    
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Title>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, title)-> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .popularFilms:
                return self.configure(collectionView: collectionView, cellType: MovieCells.self, with: title, for: indexPath)
            case .popularTVseries:
                return self.configure(collectionView: collectionView, cellType: TVCells.self, with: title, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configurate(text: section.description(), font: .laoSngamMN20(), textColor: UIColor.titleColor())
            return sectionHeader
        }
    }
}

extension VideoController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .popularFilms:
                return self.movieSection()
            case .popularTVseries:
                return self.TVSeries()
            }
        }
        return layout
    }
    
    private func movieSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150),
                                               heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = sectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func TVSeries()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                               heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        let sectionHeader = sectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}

// MARK: - SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = VideoController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> VideoController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}

