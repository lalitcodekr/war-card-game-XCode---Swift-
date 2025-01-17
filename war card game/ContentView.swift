import SwiftUI

struct ContentView: View {
    @State var playerCard = "back"
    @State var cpuCard = "back"
    
    @State var playerScore = 0
    @State var cpuScore = 0
    
    @State var playerCardRotation = 0.0
    @State var cpuCardRotation = 0.0
    
    @State var isShowingCards = false
    
    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    // Player card with rotation and mirroring fix
                    Image(playerCard)
                        .rotation3DEffect(
                            .degrees(playerCardRotation),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            perspective: 0.8
                        )
                        .scaleEffect(x: playerCardRotation.truncatingRemainder(dividingBy: 360) > 90 &&
                                     playerCardRotation.truncatingRemainder(dividingBy: 360) < 270 ? -1 : 1)
                    Spacer()
                    // CPU card with rotation and mirroring fix
                    Image(cpuCard)
                        .rotation3DEffect(
                            .degrees(cpuCardRotation),
                            axis: (x: 0.0, y: 1.0, z: 0.0),
                            perspective: 0.8
                        )
                        .scaleEffect(x: cpuCardRotation.truncatingRemainder(dividingBy: 360) > 90 &&
                                     cpuCardRotation.truncatingRemainder(dividingBy: 360) < 270 ? -1 : 1)
                    Spacer()
                }
                Spacer()
                
                Button {
                    if !isShowingCards {
                        dealWithAnimation()
                    }
                } label: {
                    Image("button")
                }
                
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .padding(.bottom)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .padding(.bottom)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .font(.headline)
                Spacer()
            }
        }
    }
    
    func dealWithAnimation() {
        isShowingCards = true
        
        // Generate new card values
        let playerCardValue = Int.random(in: 2...14)
        let cpuCardValue = Int.random(in: 2...14)
        
        // Animate the cards flipping
        withAnimation(.easeInOut(duration: 0.3)) {
            playerCardRotation += 180
            cpuCardRotation += 180
        }
        
        // After half the animation duration, update the card images
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            playerCard = "card" + String(playerCardValue)
            cpuCard = "card" + String(cpuCardValue)
            
            // Update scores
            if playerCardValue > cpuCardValue {
                playerScore += 1
            } else if playerCardValue < cpuCardValue {
                cpuScore += 1
            }
        }
        
        // After 3 seconds, flip the cards back
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut(duration: 0.5)) {
                playerCardRotation += 180
                cpuCardRotation += 180
            }
            
            // Update the card images back to "back" halfway through the animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                playerCard = "back"
                cpuCard = "back"
                isShowingCards = false
            }
        }
    }
}

#Preview {
    ContentView()
}
