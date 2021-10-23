//
//  storage.swift
//  mobile
//
//  Created by Luuk Meier on 25/09/2021.
//

import Foundation

protocol Storable: Codable, Hashable {
    var storageKey: String { get };
}

protocol Storage: ObservableObject {
    associatedtype DataType;
    var data: DataType { get set };
    func update(_ newData: DataType) -> Void;
    func getSaved(_ key: String) -> DataType;
    func save(_ key: String) -> Void;
    
}

protocol StorageArray: Storage {
    associatedtype ItemType: StackItem;
    func submit(_ item: ItemType) -> Void;
    func delete(_ item: ItemType) -> Void;
    func clear() -> Void;
    
}

extension StorageArray where DataType: HasStack {
    
    // TODO: find better solution for the "as!" fix;
    func submit(_ item: ItemType) -> Void {
        data.appendItem(item as! Self.DataType.ItemType);
        update(data)
    }

    func delete(_ item: ItemType) -> Void {
        data.removeItem(item as! Self.DataType.ItemType);
        update(data)
    }
    
    func clear() -> Void {
        data.clear()
        save(data.storageKey)
    }
}

class StorableData<T>:Storage, StorageArray where T: HasStack {
    typealias ItemType = T.ItemType;
    @Published var data: T;
    var key: String;
    var empty: T;
    
    init(_ empty: T) {
        self.data = empty;
        self.empty = empty;
        self.key = "";
        
        self.data = getSaved(data.storageKey);
        self.key = data.storageKey;
    }
    
    public func update(_ newData: T) {
        data = newData
        save(data.storageKey)
    }
    
    public func getSaved(_ key: String) -> T {
        if let stored = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoderz()
                let data = try decoder.decode(T.self, from: stored)
                return data

            } catch {
                print("Unable to Decode Note (\(error))")
                return empty
                
            }
        } else {
            print("No saved contents")
            return empty
        }
    }
    
    public func save(_ key: String) -> Void {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
}
