//
//  DataModel.swift
//  The Eye
//
//  Created by Agus Hery on 05/05/22.
//

import Foundation
import SwiftUI

struct DataModel{
    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<Tb_Transaction>
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
}
