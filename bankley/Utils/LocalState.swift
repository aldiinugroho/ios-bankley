//
//  LocalState.swift
//  bankley
//
//  Created by aldinugroho on 04/11/22.
//

import Foundation

public class LocalState {
    private enum Keys: String {
        case hasOnBoard
    }
    
    public static var hasOnBoard: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnBoard.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnBoard.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
