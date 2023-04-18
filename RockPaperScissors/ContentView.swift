//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Aleksey Novikov on 17.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var currentChoise = "rock"
    @State private var shouldWin = Bool.random()
    @State private var alertShow = false
    
    @State private var score = 0
    @State private var questionsLeft = 10
    
    let possibleChoises = ["rock", "paper", "scissors"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current score: \(score)")
            Text("App's move: \(currentChoise.capitalized)")
            Text("You should \(shouldWin ? "win" : "lose")")
            HStack {
                ForEach(possibleChoises, id: \.self) { choise in
                    Button(choise.capitalized) {
                        switch shouldWin {
                        case true:
                            if possibleChoises.firstIndex(of: currentChoise)! + 1 == possibleChoises.firstIndex(of: choise) || (currentChoise == possibleChoises.last && choise == possibleChoises.first) {
                                score += 1
                            } else {
                                score -= 1
                            }
                        case false:
                            if possibleChoises.firstIndex(of: currentChoise)! - 1 == possibleChoises.firstIndex(of: choise) || (currentChoise == possibleChoises.first && choise == possibleChoises.last) {
                                score += 1
                            } else {
                                score -= 1
                            }
                        }
                        prepareGame()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .padding()
        .alert("You've finished the game", isPresented: $alertShow) {
            Button("Ok") {
                score = 0
            }
        } message: {
            Text("Your final score is \(score)")
        }

    }
    
    func prepareGame() {
        questionsLeft -= 1
        currentChoise = possibleChoises[Int.random(in: 0...2)]
        shouldWin.toggle()
        if questionsLeft == 0 {
            alertShow = true
            questionsLeft = 10
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
