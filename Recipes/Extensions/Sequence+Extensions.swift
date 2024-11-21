//
//  Sequence+Extensions.swift
//  Recipes
//
//  Created by DJ A on 11/20/24.
//

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

