//
//  Identifiable.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/04/20.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
      return String(describing: Self.self)
    }
}

extension UITableViewCell: Identifiable { }
