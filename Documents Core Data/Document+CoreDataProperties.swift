//
//  Document+CoreDataProperties.swift
//  Documents Core Data
//
//  Created by Ante Plecas on 2/21/20.
//  Copyright © 2020 Ante Plecas. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var content: String?
    @NSManaged public var name: String?
    @NSManaged public var rawModifiedDate: NSDate?
    @NSManaged public var size: Int64

}
