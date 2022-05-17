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
    @State var didOnboarding: Bool = true
    
    typealias TransactionPrefixSum = [(String, Double)]
    
    var attributedString: AttributedString
    //    @AppStorage("didOnboarding") var didOnboarding: Bool = true
    
    init() {
        //or like this:
        attributedString = try! AttributedString(markdown: "[#More info](https://en.wikipedia.org/wiki/Moving_average)")
    }
    func dataForecasting() -> [Double]{
        guard !transactions.isEmpty else { return [] }
        let today = Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        var sum: Double = 0.0
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
            sum += dailyTotal
            
            if dailyTotal != 0.0 {
                print("NOL BESAR")
                cumulativeSum.append((date.toString(dateFormat: "dd/MM/yyyy"), sum))
                print(date.toString(dateFormat: "dd/MM/yyyy"), "Daily Total: ", dailyTotal, "sum: ", sum)
            }
        }
        return dailyAmount.filter { $0 != 0.0 }
    }
    
    func getData()->[Double]{
        let data = transactions.map(){
            $0.amount
        }
        return data
    }
    
    func Moving() -> (data: [Double], title: String){
        let data = dataForecasting()
        let dates = TransactionView()
        let windowSize: Int = 7
        var sum: Double = 0.0
        if dates.update(transactions).count > 7 {
            var forecasting: [Double] = data.suffix(7)
            for i in 0..<(windowSize) {
                sum = 0.0
                for j in i..<i+windowSize{
                    sum += forecasting[j]
                }
                forecasting.append(sum/Double(windowSize))
            }
            return (forecasting.suffix(7), "Line Chart")
        }
        else{
            return ([0], "Empty Data")
        }
    }
    
    func meanAbsoluteError() -> Double{
        let data = dataForecasting()
        let windowSize: Int = 7
        let numberSize = data.count
        var sum: Double = 0.0
        var mae: [Double] = []
        var errorResult: Double = 0.0
        for i in 0..<(numberSize-windowSize){
            sum = 0.0
            for j in i...windowSize {
                sum+=data[j]
            }
            mae.append(sum/Double(windowSize))
            
        }
        let dataActual: [Double] = data.suffix(mae.count)
        
        for i in 0..<mae.count{
            errorResult+=(abs(mae[i]-dataActual[i]))
            
        }
        return errorResult/Double(mae.count)
    }
    
    var body: some View {
        let result = Moving()
        //let marginError = meanAbsoluteError()
        NavigationView {
            VStack{
                VStack(alignment: .leading){
                    Button("Cek"){
                        print(dataForecasting())
                    }
                    Text("One type of time series forecasting is simple moving average (SMA). SMA is an arithmetic moving average calculated by adding recent prices and then dividing that figure by the number of time periods in the calculation average. \(attributedString)")
                        .font(.body)
                        .padding(.bottom,10)
                    Text("Your result can see below")
                        .font(.body.bold())
                        .multilineTextAlignment(.leading)
                }
                .padding()
                Picker(selection: $selectedValue, label: Text("")){
                    Text("Line Chart").tag(0)
                    Text("Data Result").tag(1)
                    Text("MAE").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                if result.data == [0] {
                    EmptyDataView()
                } else {
                    if selectedValue == 0 {
                        SimpleMovingAverage(data: result.data, title: result.title)
                    } else if selectedValue == 1 {
                        YourDataView(data: result.data)
                    } else {
                        MAEView(getData: meanAbsoluteError())
                    }
                }
            } // Vstak 1
            .navigationTitle("Forecasting")
        } // navView
        .fullScreenCover(isPresented: $didOnboarding, content: {
            Onboarding(didOnboarding: $didOnboarding)
        })
    } // var body
} // struct
struct YourDataView: View{
    @State var data: [Double]
    let convert = TransactionView()
    var body: some View{
        List{
            ForEach(data, id: \.self){ forecast in
                Text("Rp. \(convert.idr(amount: forecast))").tag(forecast)
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
            Text("Please Insert Minimum 8 Different Dates Recorded Transaction")
                .font(.caption)
            Spacer()
        }
    }
}

struct MAEView: View{
    @State var getData: Double
    let convert = TransactionView()
    let result = ForecastingView()
    var body: some View{
        ScrollView{
            VStack {
                Image("MAE")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Your Mean Absolute Error is...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Rp. \(convert.idr(amount: getData))")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .lineLimit(3)
                            .padding(.bottom,1)
                        Text("The mean absolute error (MAE) is the average magnitude of the error in a series of forecasts, regardless of direction. It measures accuracy for continuous variables")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding()
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
            .padding([.top, .horizontal])
        }
    }
}

struct Forecasting_Previews: PreviewProvider {
    static var previews: some View {
        ForecastingView()
    }
}
