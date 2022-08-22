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
        
        
        image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(title.backdrop_path ?? "")"))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor()
        
        setupConstraints()
        
//      СЛИШКОМ СЛОЖНАЯ ОПЕРАЦИЯ
//        APICaller.shared.getCast(ID: String(titleMovie.id), type: titleMovie.media_type ?? "") { result in
//            switch result {
//
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                self.showAlert(with: "ERROR", and: error.localizedDescription)
//            }
//        }
    }
    
    private func setupConstraints() {
        
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        
        image.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        titleName.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        
        overview.numberOfLines = 0
        overview.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        view.addSubview(image)
        view.addSubview(gradientView)
        view.addSubview(titleName)
        view.addSubview(overview)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.topAnchor),
//            image.widthAnchor.constraint(equalTo: view.widthAnchor),
            image.heightAnchor.constraint(equalToConstant: 380)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -15),
            gradientView.widthAnchor.constraint(equalTo: view.widthAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            titleName.topAnchor.constraint(equalTo: gradientView.topAnchor),
            titleName.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
            titleName.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: gradientView.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
          //  overview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
    }
}
