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
            return [0,0,0,0,0,0,0]
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                LineView(data: Moving())
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                VStack{
                    Picker(selection: $selectedValue, label: Text("someText")){
                        Text("Your Data").tag(0)
                        Text("Simple Moving Average").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    if (selectedValue == 0){
                        SubviewA()
                    }else if(selectedValue == 1){
                        SubviewB()
                    }else{
                        EmptyView()
                    }
                }
                Spacer(minLength: 100)
            } // Vstak 1
            .fullScreenCover(isPresented: $didOnboarding, content: {
                Onboarding(didOnboarding: $didOnboarding)
            })
            .navigationTitle("Status")
        } // navView
    } // var body
} // struct
struct SubviewA: View{
    var body: some View{
        Text("Subview A")
    }
}
struct SubviewB: View{
    var body: some View{
        Text("Subview B")
    }
}


struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
