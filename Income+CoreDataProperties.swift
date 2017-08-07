//
//  Income+CoreDataProperties.swift
//  ExpenseTracker2
//
//  Created by ChanKa Long on 7/8/2017.
//  Copyright © 2017 ChanKa Long. All rights reserved.
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }

    @NSManaged public var incomeDate: NSDate?
    @NSManaged public var incomeMoney: Int16
    @NSManaged public var incomeNote: String?
    @NSManaged public var incomeType: String?
    @NSManaged public var income: Key?

}
