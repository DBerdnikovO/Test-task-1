//
//  TitleViewController.swift
//  Test1
//
//  Created by Данила Бердников on 22.08.2022.
//

import Kingfisher
import UIKit

class TitleViewController: UIViewController {
    
    private var titleMovie : Title
    private var casts = [CastResult]()
    
    private var castInfo : Cast
    
   // let cast = Bundle.main.decode(Cast.self, from: "activeChats.json")
    
    
    enum Section: Int, CaseIterable {
        case  casts
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CastResult>?
    var collectionView: UICollectionView!
    
    let image = UIImageView()
    let overview = UILabel(text: "")
    let titleName = UILabel(text: "")
    let gradientView = Gradient(from: .top, to: .bottom, startColor: #colorLiteral(red: 0.3159078062, green: 0.3159078062, blue: 0.3159078062, alpha: 1), endColor: .backgroundColor())
    
    init(title: Title){
        titleMovie = title
        titleName.textColor = .titleColor()
        titleName.font = UIFont.systemFont(ofSize: 30)
        if title.original_title != nil {
            titleName.text = title.original_title
        }
        else {
            titleName.text = title.original_name
        }
        overview.text = title.overview
        overview.textColor = .titleColor()
        overview.sizeToFit()
        overview.numberOfLines = 5
        overview.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //let universityJoinChatViewModel = UniversityJoinChatViewModel(nameOfModel: universityGroupChatItem)
        
       
        
        image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(title.backdrop_path ?? "")"))
        castInfo = Cast(title: nil, cast: nil)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor()
        
    
     //   setupConstraints()
        setupCollectionView()
        createDataSource()
        reloadData()
        DispatchQueue.main.async {
            self.getCast()
        }
    }
    
    private func getCast() {
        APICaller.shared.getCast(id: String(titleMovie.id), type: titleMovie.media_type ?? "ad") { [weak self] result in
           DispatchQueue.main.async {

            switch result {

            case .success(let result):
            //  БЫЛО  self?.castInfo=result.cast
                self?.castInfo = Cast(title: self?.titleMovie, cast: result.cast)
                print(self?.castInfo.title)
        //        self?.castInfo[0].original_title
             //   print("COUNT\(result.cast.count)")
             //   print(result)
                self?.reloadData()
            case .failure(let error):
                self?.showAlert(with: "ERROR", and: error.localizedDescription)
            }
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //collectionView.backgroundColor = .blue
        view.addSubview(collectionView)
        
        collectionView.register(CastCells.self, forCellWithReuseIdentifier: CastCells.reusedId)
        
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CastResult>()
        
        snapshot.appendSections([.casts])
        
       // print(cast)
        snapshot.appendItems(castInfo.cast ?? casts, toSection: .casts)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    
}

extension TitleViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CastResult>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, cast) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            
            switch section {
            case .casts:
                print("CASTS")
               // print(cast.name ?? "error")
                return self.configure(collectionView: collectionView, cellType: CastCells.self, with: cast, for: indexPath)
            }
        })
    }
}

extension TitleViewController {
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
    
    private func createCasts() -> NSCollectionLayoutSection {
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
        return section
    }
}
