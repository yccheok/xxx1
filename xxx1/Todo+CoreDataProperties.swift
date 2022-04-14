//
//  Todo+CoreDataProperties.swift
//  xxx1
//
//  Created by Yan Cheng Cheok on 11/04/2022.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var body: String?
    @NSManaged public var title: String?

}

extension Todo : Identifiable {

}
