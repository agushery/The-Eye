//
//  GraphView.swift
//  The Eye
//
//  Created by Agus Hery on 18/05/22.
//

import SwiftUI

struct GraphView: View {
    var body: some View {
        ZStack(alignment: .top, content: {
            
            VStack(spacing: 40){
                
                HStack(spacing: 40){
                    Spacer()
                    Text("Line Chart")
                        .padding()
                } // end Hstack Title
                
                //GraphLine Background
                ForEach(0..<5, id: \.self) {i in
                    Rectangle()
                        .fill(Color.init(red: 239/255, green: 239/255, blue: 239/255))
                        .frame(height: 1)
                } // end ForEach GraphLine Background
                
                // Add Data
                HStack{
                    ForEach(1...7, id: \.self) {i in
                        Text("\(i)").tag(i)
                        if i != 7 {
                        Spacer()
                        }
                    } // end ForEach Data
                } // end Hstack Add Data
                .offset(y: -28)
            } // end Vstack
            
            HStack{
                VStack(alignment: .trailing, spacing: 22) {
                    Text(" ")
                    ForEach(Array(stride(from: 4, through: 0, by: -1)), id: \.self) {
                        i in
                        Text("\(i*250)")
                            .font(.system(size: 15, weight: .regular, design: .default))
                    } // end Foreach
                    .offset(y: -8)
                    //Spacer()
                }// end Hstack
                
            } // end Hstack
        }) // end Zstack
    } // end var body
} // end struct

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
