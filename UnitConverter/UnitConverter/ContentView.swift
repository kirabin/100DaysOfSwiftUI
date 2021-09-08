//
//  ContentView.swift
//  UnitConverter
//
//  Created by kirabin on 29.9.2020.
//

import SwiftUI

struct ContentView: View {
    let measures = ["meters", "kilometers", "feet", "yard", "miles"]
    let measures_value = [1.0, 1000.0, 0.3048, 0.9144, 1609.34]
    
    @State var value: String = ""
    @State var measure_from: Int = 0
    @State var measure_to: Int = 0
    
    var new_value: Double {
        let meters = (Double(value) ?? 0.0) * measures_value[measure_from]
        return meters / measures_value[measure_to]
    }
    
    var body: some View {
        VStack {
            TextField("Value", text: $value)
                .font(.title)
                .frame(alignment: .center)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            // from
            Section {
                VStack {
                    Picker("From", selection: $measure_from, content: {
                        ForEach(0 ..< measures.count, content: {
                            Text("\(measures[$0])")
                        })
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            // to
            Section {
                Picker("From", selection: $measure_to, content: {
                    ForEach(0 ..< measures.count, content: {
                        Text("\(measures[$0])")
                    })
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top)
            }
            Text("\(new_value, specifier: "%.2f")")
                .font(.title)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
