//
//  ViewController.swift
//  Test1
//
//  Created by Данила Бердников on 17.08.2022.
//

import UIKit
import Kingfisher

extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

final class MainMovieController: UIViewController {
    
 //   let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
  //  view.addSubview(navBar)
    
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
        
        setupCollectionView()
        createDataSource()
        reloadData()

        getTrandingMovies()
        getTrandingTVs()        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Movve"
        
        super.viewWillAppear(animated)
         let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
            nav?.tintColor = UIColor.white
    }
    
    private func getTrandingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            
                switch result {
                    
                case .success(let result):
                    if result.results.count != 0 {
                        self?.movies = result.results
                        
                        self?.reloadData()
                    }

                case .failure(let error):
                    self?.showAlert(with: "ERROR", and: error.localizedDescription)
                }

            }
        
    }
    
    private func getTrandingTVs() {
        APICaller.shared.getTrendingTVs { [weak self] result in
                switch result {
                    
                case .success(let result):
                    if result.results.count != 0 {
                        self?.TVs = result.results
                        
                        self?.reloadData()
                    }

                case .failure(let error):
                    self?.showAlert(with: "ERROR", and: error.localizedDescription)
                }
        }

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

extension MainMovieController: UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cast = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        
        
        guard let section = Section(rawValue: indexPath.section) else {return }
        
        switch section {
        case .popularFilms:
            
            let titleInfo = MovieDescriptionViewController(title: cast)
            self.navigationController?.pushViewController(titleInfo, animated:
                true)
        case .popularTVseries:
            let titleInfo = MovieDescriptionViewController(title: cast)
            self.navigationController?.pushViewController(titleInfo, animated:
                true)
        }
        
    }
}


extension MainMovieController {
    

    
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
            sectionHeader.configurate(text: section.description(), font: .systemFont(ofSize: 20), textColor: UIColor.titleColor())
            return sectionHeader
        }
    }
}

extension MainMovieController {
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 50, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
}
