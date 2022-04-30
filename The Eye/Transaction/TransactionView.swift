//
//  TransactionView.swift
//  The Eye
//
//  Created by Agus Hery on 27/04/22.
//

import SwiftUI
struct TransactionView: View {
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
                .sheet(isPresented: $isAddTransaction) {
                    AddTransactionView(coba: "")
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

