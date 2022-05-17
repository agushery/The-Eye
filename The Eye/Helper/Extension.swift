//
//  Extension.swift
//  The Eye
//
//  Created by Agus Hery on 17/05/22.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

extension Date: Strideable{
    func formatted()->String{
        return self.formatted(.dateTime.year().month().day())
    }
}
