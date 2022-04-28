//
//  TransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 27/04/22.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        NavigationView{
            // start top
            Text("Hello, Transaction!")
            
            // start tool bar after end on top
                .toolbar {
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                } // toolbar
                .navigationTitle("Transaction")
        } // navview
    } // var body
} // struck

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}

func addItem(){
    print("tambah")
}
