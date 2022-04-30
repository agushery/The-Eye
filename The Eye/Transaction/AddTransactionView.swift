//
//  AddTransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 30/04/22.
//

import SwiftUI

struct AddTransactionView: View {
    @State var coba: String
    @Environment(\.presentationMode) var presentationMode
    let types = ["Shopping", "Transport", "Food"]
    var body: some View {
        Form{
            Section(header: Text("Title")){
                TextField("Insert Title Purchase", text: $coba)
            }
                HStack{
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                          }, label: {
                              Text("Save")
                          })                }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(coba: "")
    }
}
