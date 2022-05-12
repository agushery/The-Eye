//
//  TransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 27/04/22.
//

import SwiftUI
struct TransactionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Tb_Transaction.date, ascending: false)
    ]) var transactions: FetchedResults<Tb_Transaction>
    
    
    @State var logToEdit: Tb_Transaction?
    @State var isAddTransaction: Bool = false
    @State private var query = ""
    
    
    func idr(amount: Double) -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        var harga: String = ""
        if let pass = formatter.string(from: amount as NSNumber) {
            harga = pass
        }
        return harga
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(transactions){ trans in
                        let dates = trans.date
                        HStack{
                            switch (trans.type!){
                            case "Shopping":
                                Image(systemName: "cart")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                            case "Transport":
                                Image(systemName: "car")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
                            case "Food":
                                Image(systemName: "archivebox")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                            case "Health":
                                Image(systemName: "staroflife")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                            default:
                                Image(systemName: "globe")
                                    .padding()
                                    .foregroundColor(Color(#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)))
                            }
                            VStack{
                                Text(trans.title ?? "")
                                Text(dates?.toString(dateFormat: "dd-MM-yyyy" ) ?? "")
                            }
                            Spacer()
                            VStack{
                                Text("Rp. \(idr(amount: trans.amount))")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .searchable(text: $query)
                .onChange(of: query) { newValue in
                    transactions.nsPredicate = searchPredicate(query: newValue)
                }
//                .sheet(item: $logToEdit, onDismiss: {
//                    self.logToEdit = nil
//                }) { (log: Tb_Transaction) in
//                    AddTransactionView(
//                        logToEdit: log,
//                        context: self.context,
//                        title: log.title ?? "",
//                        amount: log.amount ?? 0,
//                        type: log.type ?? "",
//                        selectedDate: log.date ?? Date()
//                    )
//                }
                .sheet(isPresented: $isAddTransaction) {
                    AddTransactionView(title: "", amount: 0, type: "", selectedDate: Date())
                }
            } // Vstak 1
            .navigationTitle("Transaction")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddTransaction.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            
        } // navview
    } // var body
    private func searchPredicate(query: String) -> NSPredicate? {
        if query.isEmpty { return nil }
        return NSPredicate(format: "%K BEGINSWITH[cd] %@",
                           #keyPath(Tb_Transaction.title), query)
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func editItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
} // struck

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
