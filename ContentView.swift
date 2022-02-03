import SwiftUI

struct ContentView: View {
    @State var score1 = 0
    @State var score2 = 0
    let winScore = 20
    @State var someoneWon = false
    var body: some View {
        
        VStack {
            Color.red
                .onTapGesture {
                    score1 += 1
                    if score1 >= winScore {
                        someoneWon = true
                        score1 = 0
                        score2 = 2
                    }
                }
            HStack {
                Text("Player 1: \(score1)")
                Spacer()
                Text("Player 2: \(score2)")
            }
            Color.blue
                .onTapGesture {
                    score2 += 1
                    if score2 >= winScore {
                        someoneWon = true
                        score1 = 0
                        score2 = 0
                    }
                }
        }
        .alert("Winner", isPresented: $someoneWon) {
            
        }
    }
}
