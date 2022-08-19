//
//  SelfConfigCellProtocol.swift
//  Test1
//
//  Created by Данила Бердников on 19.08.2022.
//

import Foundation

protocol SelfConfigCell {
    static var reusedId: String {get}
    func configure<U: Hashable>(with value: U)
}
