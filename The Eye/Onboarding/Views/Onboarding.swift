//
//  Onboarding.swift
//  The Eye
//
//  Created by Agus Hery on 25/04/22.
//

import Foundation
import SwiftUI

struct Onboarding: View {
    
    @State var offset: CGFloat = 0
    //@State var titleButtonNext: String = "Next"
    var i: Int = 0
    
    var body: some View {
        // Custom pager view
        OffsetPageTabView(offset: $offset) {
            HStack(spacing: 0) {
                ForEach(boardingScreen){screen in
                    VStack(spacing: 15) {
                        Image(screen.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getScreenBounds().width - 100, height: getScreenBounds().height - 500)
                            .offset(y: -120)
                        
                        VStack(alignment: .leading, spacing: 12){
                            Text(screen.title)
                                .font(.largeTitle.bold())
                                .kerning(1.5)
                                .foregroundColor(.white)
                            Text(screen.description)
                                .fontWeight(.semibold)
                                .kerning(1)
                                .foregroundColor(.white)
                        }// Vstack 2
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                    } // Vstak 1
                    .padding()
                    .frame(width: getScreenBounds().width)
                    .frame(maxHeight: .infinity)

                    
                } // foreach
                
            } // hstack
            
        } // offsetpage
        //create custom background
        .background(
            RoundedRectangle(cornerRadius:  50)
                .fill(.white)
            // size as image size
                .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 150)
                .scaleEffect(2)
                //.rotationEffect(.init(degrees: -270))
                .rotationEffect(.init(degrees: getRotation()))
                .offset(y: -getScreenBounds().width + 100)
            
            ,alignment: .leading
        )
        
        .background(Color("Onboarding\(getIndex() + 1)")
            .animation(.easeInOut, value: getIndex())
        )//Animating
        .ignoresSafeArea(.container, edges: .all)
        .overlay(
            HStack{
                Button{
 
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                } // button
                
                // indicator
                HStack {
                    ForEach(boardingScreen.indices, id: \.self){index in
                        Circle()
                            .fill(.white)
                            .opacity(index == (getIndex()) ? 1 : 0.4)
                            .frame(width: 10, height: 10)
                            .scaleEffect(index == getIndex() ? 1.3 : 0.85)
                            .animation(.easeInOut, value: getIndex())
                    }
                }
                .frame(maxWidth: .infinity)
                
                Button{
                    // setting mac offset..
                    // max 3 screen so offset is 2
                    offset = min(offset + getScreenBounds().width, getScreenBounds().width*2)
                    print(offset)
                } label: {
                    Text("Next")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }//button
                
            }
                .padding()
                .padding(.top,25)
                .padding(.horizontal,8)
            ,alignment: .bottom
            // hstack-overlay
            
        )// overlay
        
    } //var
    
    //getting rotation
    func getRotation()->Double{
        let progress = offset /  (getScreenBounds().width*4)
        let rotation = Double(progress) * 360
        return rotation
    }
    
    // change background color based on offset
    func getIndex()->Int{
        let progress = (offset / getScreenBounds().width).rounded()
        return Int(progress)
    } //func getIndex
    
} // struct

struct Onboarding_View: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

// extending view to get screen bounds
extension View {
    func getScreenBounds()->CGRect{
        return UIScreen.main.bounds
    }
}
