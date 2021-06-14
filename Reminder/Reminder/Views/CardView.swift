//
//  CardView.swift
//  Reminder
//
//  Created by Simon Steuer on 09/06/2021.
//

import SwiftUI

struct CardView: View {
    @State private var flipped = false
    @State public var enabled = false
    var cardViewModel:CardViewModel!

    var body: some View {
        RoundedRectangle(cornerRadius: 6).fill((enabled ? Color.green : Color.white)).border(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom), width: 5).cornerRadius(7)
            .frame(height: 120)
            .overlay(
                ZStack {
                    HStack {
                        
                        VStack {
                            Image("checkmark")
                                
                                .opacity(enabled ? 1 : 0)
                            
                        }
                    }
                    VStack {
                        Text(cardViewModel.studyCard.remind)
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size: 24).bold())
                            .opacity(enabled ? 0 : 1)
                        Text(cardViewModel.studyCard.date)
                            .foregroundColor(Color.black)
                            .font(.custom("Avenir", size: 18))
                            .opacity(enabled ? 0 : 1)
                            .padding(2)
                    }
                }.padding()
            )
            .animation(.default)
            
            
            
        
    }
}
