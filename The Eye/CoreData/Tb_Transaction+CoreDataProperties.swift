//
//  Tb_Transaction+CoreDataProperties.swift
//  The Eye
//
//  Created by Agus Hery on 05/05/22.
//
//

import Foundation
import CoreData


extension Tb_Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tb_Transaction> {
        return NSFetchRequest<Tb_Transaction>(entityName: "Tb_Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}

extension Tb_Transaction : Identifiable {

}
