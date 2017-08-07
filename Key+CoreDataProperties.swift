//
//  Key+CoreDataProperties.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 7/8/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import Foundation
import CoreData


extension Key {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Key> {
        return NSFetchRequest<Key>(entityName: "Key")
    }

    @NSManaged public var dateKey: String?
    @NSManaged public var expenseDetails: Set<Expense>?
    @NSManaged public var incomeDetails: Set<Income>?

}

// MARK: Generated accessors for expenseDetails
extension Key {

    @objc(addExpenseDetailsObject:)
    @NSManaged public func addToExpenseDetails(_ value: Expense)

    @objc(removeExpenseDetailsObject:)
    @NSManaged public func removeFromExpenseDetails(_ value: Expense)

    @objc(addExpenseDetails:)
    @NSManaged public func addToExpenseDetails(_ values: NSSet)

    @objc(removeExpenseDetails:)
    @NSManaged public func removeFromExpenseDetails(_ values: NSSet)

}
