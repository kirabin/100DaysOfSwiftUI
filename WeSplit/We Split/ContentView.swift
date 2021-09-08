//
//  ContentView.swift
//  We Split
//
//  Created by kirabin on 28.9.2020.
//

import SwiftUI

struct ContentView: View {
    
    let tipPercentages = [0, 10, 15, 20, 25]
    @State var tipPercentage: Int = 0
    @State var checkAmount: String = ""
    @State var peopleAmount: Int = 0
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(peopleAmount + 1)
        let tipSection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount / peopleCount * (tipSection / 100.0 + 1)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (content: {
                    HStack {
                        Text("Check Amount")
                        Spacer()
                        TextField("", text: $checkAmount)
                            .keyboardType(.decimalPad)
                            .frame(width: 80, alignment: .trailing)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .offset(x: 14)
                    }
                    HStack{
                        Text("People")
                        Spacer()
                        Picker("", selection: $peopleAmount, content: {
                            ForEach(1 ..< 20, content: {
                                Text("\($0)")
                            })
                        })
    //                    .pickerStyle(InlinePickerStyle())
                            
                    }
                })
                Section(header: Text("Tip Persentage"), content: {
                    Picker("Tip Percentage", selection: $tipPercentage, content: {
                        ForEach(0 ..< tipPercentages.count, content: {
                            Text("\(tipPercentages[$0])")
                        })
                    })
                    .pickerStyle(SegmentedPickerStyle())
                })
                
                Section {
                    HStack {
                        Text("Amount per person:")
                        Spacer()
                        Text("\(totalPerPerson, specifier: "%.2f")")
                            .foregroundColor(tipPercentage == 0 ? .red : .primary)
                    }
                }
            }
            .navigationTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

