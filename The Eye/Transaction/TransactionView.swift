//
//  TransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 27/04/22.
//

import SwiftUI
struct TransactionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<Tb_Transaction>

    
    @State var isAddTransaction: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Transaction")
                        .font(.largeTitle.bold())
                        .kerning(1.2)
                        .padding()
                    Spacer()
                    
                    Button(action: {
                        isAddTransaction.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("Theme"))
                            .padding()
                    })
                } // hastack
                List{
                    ForEach(transactions){ trans in
                        VStack{
                            Text(trans.title ?? "Empty")
                            Text(trans.type ?? "Empty")
                            Text(String(trans.amount))
                        }
                    }
                }
                .sheet(isPresented: $isAddTransaction) {
                    AddTransactionView(title: "", amount: 0, type: "")
                }
                Spacer()
            } // Vstak 1
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        } // navview
    } // var body
} // struck

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}

