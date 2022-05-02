//
//  AddTransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 30/04/22.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    
    @State var title: String
    @State var amount: Int32
    @State var type: String
    @State var selectedDate: Date
    
    
    let types = ["Shopping", "Transport", "Food", "Health", "Others"]
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Title")){
                    TextField("Insert Title Purchase", text: $title)
                        .disableAutocorrection(true)
                }
                Section(header: Text("Type")){
                    Picker("Type of transaction",selection: $type){
                        ForEach(types, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Amount")){
                    HStack{
                        Text("Rp. ")
                        TextField("Insert Amount Purchase", value: $amount, format: .number)
                            .disableAutocorrection(true)
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Text("Date of transaction")
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    }
                    
                }
                
                Button(action: {
                    let newTransaction = Tb_Transaction(context: moc)
                    newTransaction.id = UUID()
                    newTransaction.title = title
                    newTransaction.type = type
                    newTransaction.amount = Int32(amount)
                    newTransaction.date = selectedDate
                    do {
                        try self.moc.save()
                    } catch {
                        print("whoops \(error.localizedDescription)")
                    }
                    self.dismiss.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    } // var body
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(title: "", amount: 0, type: "", selectedDate: Date())
    }
}
