//
//  TitleViewController.swift
//  Test1
//
//  Created by Данила Бердников on 22.08.2022.
//

import Kingfisher
import UIKit

final class MovieDescriptionViewController: UIViewController {
    
    var viewcontroller = UIViewController()

    

    
    
    private var titleMovie : Title
    private var castss = [CastResult]()
    
    fileprivate let headerId = "headerId"

    private var castInfo : Cast
    
    
    
    enum Section: Int, CaseIterable {
        case  casts
        
        func description() -> String {
            switch self{
                
            case .casts:
                return "Casts"
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CastResult>?
    var collectionView: UICollectionView!
    
    let image = UIImageView()
    let overview = UILabel()
    let titleName = UILabel()

    
    init(title: Title){
        titleMovie = title
        titleName.textColor = .titleColor()
        titleName.font = UIFont.systemFont(ofSize: 30)
        titleName.text = title.title
        overview.text = title.overview
        overview.textColor = .titleColor()
        overview.sizeToFit()
        overview.numberOfLines = 5
        overview.lineBreakMode = NSLineBreakMode.byWordWrapping
        

        image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(title.backdrop_path ?? "")"))
        castInfo = Cast(title: nil, cast: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(goFavorits))
        setupCollectionView()
        createDataSource()
        reloadData()
        getCast()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    
    @objc func goFavorits() {
        let isLike : Bool = inFav()
        if isLike == false {
            FavoritsDelegate.shared.addCast(new: self.castInfo)
        }
        else {
            FavoritsDelegate.shared.deleteFav(deletecast: self.castInfo)
        }
    }
    
    private func inFav() -> Bool {
        
        let favArray = FavoritsDelegate.shared.getIdFav()
        for like in favArray{
            if like == self.castInfo.title?.id {
                return true
            }
        }
        
        return false
    }
    
    private func getCast() {
        APICaller.shared.getCast(id: String(titleMovie.id), type: titleMovie.media_type ?? "ad") { [weak self] result in

            switch result {

            case .success(let result):
                self?.castInfo = Cast(title: self?.titleMovie, cast: result.cast)

                self?.reloadData()
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

        collectionView.register(TitleCell.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: TitleCell.reusedId)
        
        collectionView.register(FooterCell.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: FooterCell.id)
      
        collectionView.register(CastsCells.self, forCellWithReuseIdentifier: CastsCells.reusedId)
        

        
        
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CastResult>()
        
        snapshot.appendSections([.casts])

        snapshot.appendItems(castInfo.cast ?? castss , toSection: .casts)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        
        
    }

}



extension MovieDescriptionViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CastResult>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, cast) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .casts:
                return self.configure(collectionView: collectionView, cellType: CastsCells.self, with: cast, for: indexPath)
            }
        })
        
    
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionFooter {
                
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind:UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: FooterCell.id,
                    for: indexPath) as! FooterCell
                footer.configure()
                
                NSLayoutConstraint.activate([
                    footer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    footer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    footer.heightAnchor.constraint(equalToConstant: 100)
                ])
                
        return footer }
            else {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: TitleCell.reusedId,
                    for: indexPath) as! TitleCell
                
                header.configure(with: self.titleMovie )
                
                NSLayoutConstraint.activate([
                    header.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    header.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
                return header
            }

        }
    }
}

extension MovieDescriptionViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .casts:
                return self.createCasts()
            }
        }
        return layout
    }

    
    private func createCasts()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(130),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 2
        let sectionHeader = sectionHeader()
        let sectionFooter = sectionFooter()
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return sectionHeader
    }
    private func sectionFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        return sectionFooter
    }
    
}

