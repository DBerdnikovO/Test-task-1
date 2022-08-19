//
//  String Extension.swift
//  Test1
//
//  Created by Данила Бердников on 18.08.2022.
//

import Foundation

extension StringProtocol {
  var firstUppercased: String {
    return prefix(1).uppercased() + dropFirst()
  }

  var displayNicely: String {
    return firstUppercased.replacingOccurrences(of: "_", with: " ")
  }
}
