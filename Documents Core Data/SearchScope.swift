//
//  SearchScope.swift
//  Documents Core Data
//
//  Created by Ante Plecas on 3/5/20.
//  Copyright © 2020 Ante Plecas. All rights reserved.
//

import Foundation

enum SearchScope: String {
    case all
    case name
    case content
    
    static var titles: [String] {
        get {
            return [SearchScope.all.rawValue, SearchScope.name.rawValue, SearchScope.content.rawValue]
        }
    }
    
    static var scopes: [SearchScope] {
        get {
            return [SearchScope.all, SearchScope.name, SearchScope.content]
        }
    }
}
