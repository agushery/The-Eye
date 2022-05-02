//
//  Profile+CoreDataProperties.swift
//  The Eye
//
//  Created by Agus Hery on 02/05/22.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var income: String?
    @NSManaged public var lastname: String?

}

extension Profile : Identifiable {

}
