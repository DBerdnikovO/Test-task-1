//
//  UIViewController.swift
//  Test1
//
//  Created by Данила Бердников on 19.08.2022.
//

import UIKit

extension UIViewController {
    
   // return self.configure(collectionView: collectionView, cellType: MovieCells.self, with: title, for: indexPath)
    
    
    
     func configure<T: SelfConfigCell, U:Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath)-> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reusedId, for: indexPath)
                as? T else { fatalError("Unable to dequeu \(cellType)")}
         
         cell.configure(with: value)
        return cell
        
    }
}

extension UIViewController {
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
