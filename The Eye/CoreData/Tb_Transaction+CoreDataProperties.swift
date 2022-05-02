//
//  Tb_Transaction+CoreDataProperties.swift
//  The Eye
//
//  Created by Agus Hery on 02/05/22.
//
//

import Foundation
import CoreData


extension Tb_Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tb_Transaction> {
        return NSFetchRequest<Tb_Transaction>(entityName: "Tb_Transaction")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var date: Date?

}

extension Tb_Transaction : Identifiable {

}
