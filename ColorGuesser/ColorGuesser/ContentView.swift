//
//  ContentView.swift
//  ColorGuesser
//
//  Created by kirabin on 24.9.2020.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double = 0.5
    @State var gGuess: Double = 0.5
    @State var bGuess: Double = 0.5 // read only value
    @State var showAlert: Bool = false
    
    func getDifference() -> Int {
        return Int(abs(rTarget-rGuess) * 255.0 +
                   abs(gTarget-gGuess) * 255.0 +
                   abs(bTarget-bGuess) * 255.0)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                    Text("Match this color")
                }
                VStack {
                    Rectangle()
                        .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    HStack {
                      Text("\(Int(rGuess * 255.0))")
                        .foregroundColor(.red)
                      Text("\(Int(gGuess * 255.0))")
                        .foregroundColor(.green)
                      Text("\(Int(bGuess * 255.0))")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
            .padding()
            
            Button(action: {
                self.showAlert = true // self needed because variable is in closure
            }, label: {
                Text("Check")
            })
            .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Actual Color"), message: Text("R: \(Int(rTarget * 255.0))\nG: \(Int(gTarget * 255.0))\nB: \(Int(bTarget * 255.0))\n\nDiffernce: \(getDifference())"))
            })
            .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorSlider: View {
    
    @Binding var value: Double
    var  textColor: Color
    
    var body: some View {
        Slider(value: $value)  // read-write binding
            .accentColor(textColor)
    }
}



