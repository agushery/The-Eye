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
        let windowSize: Int = 7
        var sum: Double = 0.0
        if data.count > 6 {
            var forecasting: [Double] = data.suffix(7)
            for i in 0..<(windowSize) {
                sum = 0.0
                for j in i..<i+windowSize{
                    sum += forecasting[j]
                }
                forecasting.append(sum/Double(windowSize))
            }
            return (forecasting.suffix(7), "")
        }
        else{
            return ([0], "Empty Data")
        }
    }
    
    var body: some View {
        let result = Moving()
        NavigationView {
            VStack{
                VStack(alignment: .leading){
                    Text("A simple moving average (SMA) is an arithmetic moving average calculated by adding recent prices and then dividing that figure by the number of time periods in the calculation average. Short-term averages respond quickly to changes in the price of the underlying security, while long-term averages are slower to react.")
                        .font(.body)
                    Text("Your result can see below")
                        .font(.body.bold())
                        .multilineTextAlignment(.leading)
                }
                .padding()
                Picker(selection: $selectedValue, label: Text("")){
                    Text("Line Chart").tag(0)
                    Text("Data Result").tag(1)
                    Text("Margin Error").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                if result.data == [0] {
                    EmptyDataView()
                } else {
                    if selectedValue == 0 {
                        SimpleMovingAverage(data: result.data, title: result.title)
                    } else if selectedValue == 1 {
                        YourDataView(data: result.data)
                    } else {
                        MarginErrorView(getData: getData())
                    }
                }
            } // Vstak 1
            .navigationTitle("Forecasting")
        } // navView
    } // var body
} // struct
struct YourDataView: View{
    @State var data: [Double]
    var body: some View{
        List{
            ForEach(data, id: \.self){ forecast in
                Text("Rp. \(forecast)").tag(forecast)
            }
        }
        Spacer()
    }
}
struct SimpleMovingAverage: View{
    @State var data: [Double]
    @State var title: String?
    
    
    var body: some View{
        ScrollView{
            LineView(data: data, title: title)
                .padding()
        }
        Spacer()
    }
}

struct EmptyDataView: View{
    var body: some View{
        VStack{
            Spacer()
            Text("Data Not Found")
                .font(.title)
            Text("Please Insert Transaction")
                .font(.caption)
            Spacer()
        }
    }
}

struct MarginErrorView: View{
    @State var getData: [Double]
    var body: some View{
        VStack{
            Spacer()
            ForEach(getData, id: \.self){forecast in
                Text("\(forecast)").tag(forecast)
            }
            Spacer()
        }
    }
}

struct Forecasting_Previews: PreviewProvider {
    static var previews: some View {
        ForecastingView()
    }
}
