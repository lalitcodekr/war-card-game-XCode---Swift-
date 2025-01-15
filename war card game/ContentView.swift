//
//  ContentView.swift
//  war card game
//
//  Created by Pyda Lalit Kumar on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var playerCard = "card7"
    @State var cpuCard = "card13"
    
    @State var playerScore = 0
    @State var cpuScore = 0
    
    var body: some View {
        
        ZStack{
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Image("logo")
                Spacer()
                HStack{
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()
                
                Button {
                    deal()
                } label: {
                    Image("button")
                }

                
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("Player")
                            .padding(.bottom,12)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack{
                        Text("CPU")
                            .padding(.bottom,12)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }.foregroundColor(.white).font(.headline)
                Spacer()
            }
        }
    }
    
    func deal() {
        // Randomize the player card
        var playerCardValue = Int.random(in: 2...14)
        playerCard = "card" + String(playerCardValue)
        
        // Randomize the cpu card
        var cpuCardValue = Int.random(in: 2...14)
        cpuCard = "card" + String(cpuCardValue)
        
        // Update the scores
        if playerCardValue > cpuCardValue {
            // Add 1 to player score
            playerScore += 1
        }
        else if playerCardValue < cpuCardValue {
            // Add 1 to cpu score
            cpuScore += 1
        }
    }
}

#Preview {
    ContentView()
}
