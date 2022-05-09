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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Tb_Transaction>
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
    func Moving() -> [Double]{
        let data = getData()
        let windowSize: Int = 3
        var sum: Double = 0.0
        var movingAverage: Double = 0.0
        let numberSize: Int = 9
        if data.count > 7 {
            var forecasting: [Double] = data.suffix(7)
            for i in 0...(numberSize-windowSize) {
                for j in i..<i+windowSize{
                    sum += forecasting[j]
//                    print("\(forecasting[j]), ")
                }
                movingAverage = sum / Double(windowSize)
                forecasting.append(movingAverage)
//                print("Moving average: \(movingAverage)")
            }
//            print(forecasting)
            return forecasting.suffix(7)
        }
        else{
            return [7,6,5,4,3,2,1]
        }
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
                NavigationLink(destination: TransactionView()){
                    VStack{
                    Text("Simple Moving Average")
                    LineView(data: Moving())
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                }
                
                HStack{
                    Text("Simple Moving Average")
                }
                Spacer(minLength: 20)
            } // Vstak 1
            .fullScreenCover(isPresented: $didOnboarding, content: {
                Onboarding(didOnboarding: $didOnboarding)
            })
            .navigationTitle("Status")
            .navigationBarHidden(true)
        } // navView
    } // var body
} // struct

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
