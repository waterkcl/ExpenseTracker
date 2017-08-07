//
//  Expense+CoreDataProperties.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 7/8/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var expenseDate: NSDate?
    @NSManaged public var expenseMoney: Int16
    @NSManaged public var expenseNote: String?
    @NSManaged public var expenseType: String?
    @NSManaged public var expense: Key?

}
