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
    
    
    @State var isEdit: Bool = false
    @State var isAddTransaction: Bool = false
    @State private var query = ""
    @State private var needsRefresh: Bool = false
    typealias TransactionPrefixSum = [(String, Double)]
    
    
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
    func update(_ result : FetchedResults<Tb_Transaction>)-> [[Tb_Transaction]]{
        return  Dictionary(grouping: result){ (element : Tb_Transaction)  in
            element.date!.toString(dateFormat: "dd-MM-yyyy")
        }.values.sorted() { $0[0].date! > $1[0].date! }
    }
    
    func listData() -> TransactionPrefixSum{
        guard !transactions.isEmpty else { return [] }
        let today = Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        var cumulativeSum = TransactionPrefixSum()
        var dailyAmount: [Double] = []
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            
            let dailyExpenses = transactions.filter{
//                print("DATE FOR LOOP: ",date)
//                print("DATE CORE DATA: ", $0.date!)
                return $0.date?.toString(dateFormat: "dd/MM/yyyy") == date.toString(dateFormat: "dd/MM/yyyy")
            }
            let dailyTotal = dailyExpenses.reduce(0) { $0 + $1.amount }
            //print(dailyExpenses)
            
            dailyAmount.append(dailyTotal)
            
            if dailyTotal != 0.0 {
                cumulativeSum.append((date.toString(dateFormat: "dd/MM/yyyy"), dailyTotal))
                print(date.toString(dateFormat: "dd/MM/yyyy"), "Daily Total: ", dailyTotal)
            }
        }
        print(type(of: [Tb_Transaction].self))
        return cumulativeSum
    }
    var body: some View {
        NavigationView{
            VStack{
                Button("CEK"){
                    print(listData())
                }
                List {
                    ForEach(update(transactions), id: \.self) { (section: [Tb_Transaction]) in
                        let dailyTotal = section.reduce(0) { $0 + $1.amount }
                        Section(header:
                                    HStack{
                                    Text( section[0].date!.toString(dateFormat: "dd-MM-yyyy" ))
                            Spacer()
                            Text("Rp.\(idr(amount: dailyTotal))")
                        }
                        ) {
                            
                            ForEach(section, id: \.self) { todo in
                                HStack {
                                    switch (todo.type!){
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
                                    case "Donation":
                                        Image(systemName: "heart.circle.fill")
                                            .padding()
                                            .foregroundColor(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                                    case "Entertainment":
                                        Image(systemName: "tv.music.note")
                                            .padding()
                                            .foregroundColor(Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)))
                                    case "Utilities":
                                        Image(systemName: "bolt")
                                            .padding()
                                            .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
                                    default:
                                        Image(systemName: "tag")
                                            .padding()
                                            .foregroundColor(Color(#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)))
                                    }
                                    Text(todo.title ?? "")
                                    Spacer()
                                    Text("Rp. \(idr(amount: todo.amount))")
                                }
                            }
                            //.onDelete(perform: deleteItems)
                            .onDelete { indexSet in
                                deleteItem(section: Array(section), offsets: indexSet)
                                }
                        }
                    }.id(transactions.count)
                    
                }
                .searchable(text: $query)
                .onChange(of: query) { newValue in
                    transactions.nsPredicate = searchPredicate(query: newValue)
                }
                .sheet(isPresented: $isAddTransaction) {
                    AddTransactionView(title: "", amount: nil, type: "", selectedDate: Date())
                }
            } // Vstak 1
            .navigationTitle("Transaction")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddTransaction.toggle()
                    }, label: {
                        HStack{
                            Image(systemName: "plus")
                            Text("Add")
                        }
                        
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
    private func deleteItem(section: [Tb_Transaction], offsets: IndexSet) {
        for index in offsets {
            let item = section[index]
            moc.delete(item)
        }
        do {
            try moc.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

} // struck

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
