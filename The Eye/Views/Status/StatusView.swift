//
//  StatusView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI
import SwiftUICharts

struct StatusView: View {
    @State var didOnboarding: Bool = true
    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<Tb_Transaction>
    
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                HStack{
                    Text("Welcome Agus")
                        .font(.largeTitle.bold())
                        .kerning(1.2)
                        .padding()
                    Spacer()
                    NavigationLink(destination: ProfileView(income: "")){
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("Theme"))
                            .padding(.trailing,25)
                    } //navlink
                } // hastack
                
                //
                CardView{
                    ChartLabel("", type: .title)
                    LineChart()
                }
                .data(getData())
                .chartStyle(ChartStyle(backgroundColor: .white,
                                       foregroundColor: ColorGradient(.blue, .blue)))
                .frame(maxWidth: .infinity-500, maxHeight: 200)
                //
                
                Spacer()
                Text("Test")
            } // Vstak 1
            .fullScreenCover(isPresented: $didOnboarding, content: {
                Onboarding(didOnboarding: $didOnboarding)
            })
            .navigationTitle("Status")
            .navigationBarHidden(true)
        } // navView
    } // var body
} // struct

//struct StatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusView(myData: <#T##DataModel#>)
//    }
//}
