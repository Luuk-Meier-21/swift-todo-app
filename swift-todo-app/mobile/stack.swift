//
//  stack.swift
//  mobile
//
//  Created by Luuk Meier on 05/10/2021.
//

import Foundation

protocol HasStack: Storable {
    associatedtype ItemType: StackItem;
    var array: [ItemType] { get set };
}

protocol StackItem: Codable, Hashable {
    var index: Int { get set };
}

extension HasStack {
    mutating func clear() {
        array = [];
    }
    
    var isEmpty: Bool {
        return array.count == 0
    }
    
    mutating func appendItem(_ item: ItemType) {
        var newArray = array;
        newArray.append(item)
        array = count(newArray)
    }

    mutating func removeItem(_ item: ItemType) {
        let newArray = array.filter { a in
            return a.index != item.index
        }
        array = count(newArray)
    }

    func count(_ array: [ItemType]) -> [ItemType] {
        var newArray: [ItemType] = array;
        newArray = [];
        for (index, var item) in array.enumerated() {
            item.index = index;
            newArray.append(item)
        }
        return newArray
    }
}
