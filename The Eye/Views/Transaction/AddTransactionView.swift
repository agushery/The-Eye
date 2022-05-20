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
    @State var amount: Double?
    @State var type: String
    @State var selectedDate: Date
    @State private var showingAlert = false
    
    
    let types = ["Shopping", "Transport", "Food", "Health", "Donation", "Entertainment", "Utilities","Others"]
    
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
                }
                Section(header: Text("Amount")){
                    HStack{
                        Text("IDR.")
                        TextField("Insert Amount Purchase", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("Date")){
                    HStack{
                        Text("Date of transaction")
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    }
                    
                }
                
                Button("Save"){
                    if title.isEmpty || ((amount?.isNaN) == nil) || type.isEmpty {
                        showingAlert.toggle()
                    } else {
                        let newTransaction = Tb_Transaction(context: moc)
                        newTransaction.id = UUID()
                        newTransaction.title = title
                        newTransaction.type = type
                        newTransaction.amount = Double(amount!)
                        newTransaction.date = selectedDate
                        do {
                            try self.moc.save()
                        } catch {
                            print("whoops \(error.localizedDescription)")
                        }
                        self.dismiss.wrappedValue.dismiss()
                    }
                }
                .alert("Please fill the data", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    } // var body
}
