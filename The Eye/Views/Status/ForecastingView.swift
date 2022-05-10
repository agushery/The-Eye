//
//  StatusView.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import SwiftUI
import SwiftUICharts

struct ForecastingView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var transactions: FetchedResults<Tb_Transaction>
    @State var selectedValue = 0

    
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
    func Moving() -> (data: [Double], title: String){
        let data = getData()
        let windowSize: Int = 3
        var sum: Double = 0.0
        var movingAverage: Double = 0.0
        let numberSize: Int = 9
        if data.count > 6 {
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
            return (forecasting.suffix(7), "")
        }
        else{
            return ([0,0,0,0,0,0,0], "Empty Data")
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
                VStack{
                    Text("Ga je")
                }
                Spacer(minLength: 100)
            } // Vstak 1
            .navigationTitle("Forecasting")
        } // navView
    } // var body
} // struct


struct Forecasting_Previews: PreviewProvider {
    static var previews: some View {
        ForecastingView()
    }
}
