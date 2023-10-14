//
//  ContentView.swift
//  Card Game
//
//  Created by Jasurbek Khamroev on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isRefreshing = false
    
    @State var playerCard = "back"
    @State var AIcard = "back"
    @State var refreshshedCard = "back"
    
    @State var playerScore:Int = 0
    @State var AIScore:Int = 0
    @State var refreshshedScore = 0
    
    @State var isGameOver = false
    @State var whoIsWinner = ""
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                
                HStack{
                    Spacer()
                    //Refresh Button
                    Button(action: {
                        withAnimation{
                            isRefreshing.toggle()
                            refresh()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.orange)
                    }
                    .rotationEffect(isRefreshing ? .degrees(360) : .degrees(0))
                }
                .padding(.trailing, 10.0)
                
                
                Spacer()
                Image("logo")
                
                Spacer()
                HStack{
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(AIcard)
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
                            .font(.title2)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.title)
                    }
                    Spacer()
                    VStack{
                        Text("AI")
                            .font(.title2)
                            .padding(.bottom, 10.0)
                        Text(String(AIScore))
                            .font(.title)
                    }
                    Spacer()
                }
                .fontWeight(.heavy)
                .monospaced()
                .foregroundColor(.gray)
                Spacer()
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(
            Image("card-background")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .opacity(0.5)
                .background(.black)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        )
        
        
        //displaying the winner
        .alert(isPresented: $isGameOver) {
            Alert(
                title: Text("\(whoIsWinner) wins!"),
                message: Text("Game Over"),
                dismissButton: .default(Text("OK")) {
                    // Reset the game when the user dismisses the alert
                    refresh()
                    isGameOver = false
                }
            )
        }
    }
    
    func deal(){
        
        //Changing Player's card
        let randomPlayerCard:Int = Int.random(in: 2...14)
        playerCard = "card" + String(randomPlayerCard)
        
        //Changing AI's card
        let randomAICard:Int = Int.random(in: 2...14)
        AIcard = "card" + String(randomAICard)
        
        //Updating the scores
        if(randomPlayerCard > randomAICard){
            playerScore += 1
        }
        else if (randomAICard > randomPlayerCard){
            AIScore += 1
        }
        
        checkWinner()
        
    }
    
    func checkWinner(){
        if(playerScore == 10){
            isGameOver = true
            whoIsWinner = "Player"
        }
        else if (AIScore == 10){
            isGameOver = true
            whoIsWinner = "AI"
        }
    }
    
    func refresh(){
        playerCard = refreshshedCard
        AIcard = refreshshedCard
        
        playerScore = refreshshedScore
        AIScore = refreshshedScore
    }
    
}

#Preview {
    ContentView()
}
