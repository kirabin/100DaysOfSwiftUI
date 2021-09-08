//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by kirabin on 1.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0 ..< 3)
    
    @State var scoreTitle = ""
    @State var showingScore = false
    @State var choosenFlag = 0
    @State var answers = 0
    @State var correctAnswers = 0
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Tap the flag of \(countries[correctAnswer])")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                    
                    ForEach(0 ..< 3, content: { num in
                        Button(action: {
                            flagTapped(num)
                        }, label: {
                            Image(countries[num])
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        })
                        .padding()
                        .alert(isPresented: $showingScore, content: {
                            Alert(title: Text(scoreTitle).font(.title),
                                  message: Text(scoreTitle == "Wrong" ? "You chose flag of \(countries[choosenFlag])" : ""),
                                  dismissButton: .default(Text("Next Question")) {
                                askQuestion()
                            })
                        })
                        
                    })
                    Spacer()
                    Text("Score: \(answers != 0 ? Double(correctAnswers) * 100 / Double(answers) : 0, specifier: "%.1f")%")
                        .font(.title)
                        .padding()
                }
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            correctAnswers += 1
        }
        else {
            scoreTitle = "Wrong"
        }
        
        answers += 1
        choosenFlag = number
        showingScore = true
    }
    
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ..< 3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
