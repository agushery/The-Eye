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
    @State var selectedValue = 0
    
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
    func Moving() -> (data: [Double], title: String?){
        let data = getData()
        let windowSize: Int = 3
        var sum: Double = 0.0
        var movingAverage: Double = 0.0
        let numberSize: Int = 9
        let chartTitle: String = "Empty Data"
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
            return (forecasting.suffix(7), nil)
        }
        else{
            return ([0,0,0,0,0,0,0], chartTitle)
        }
    }
    
    var body: some View {
        let result = Moving()
        NavigationView {
            VStack(alignment: .center){
                LineView(data: result.data, title: result.title)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                Text("Test")
            } // Vstak 1
            .fullScreenCover(isPresented: $didOnboarding, content: {
                Onboarding(didOnboarding: $didOnboarding)
            })
            .navigationTitle("Status")
        } // navView
    } // var body
} // struct


struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
