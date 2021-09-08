//
//  ContentView.swift
//  BetterRest
//
//  Created by kirabin on 4.9.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8
    @State private var wakeUp = Date();
    
    var body: some View {
        VStack {
            TestView()
                .padding()
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%.2f") hours")
            }
            DatePicker("Select wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
        }
        .padding()
    }
}

struct TestView: View {
        @State var timeNow = ""
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        var dateFormatter: DateFormatter {
                let fmtr = DateFormatter()
                fmtr.dateFormat = "LLLL dd, hh:mm:ss a"
                return fmtr
        }
        
        var body: some View {
                Text("Currently: " + timeNow)
                        .onReceive(timer) { _ in
                                self.timeNow = dateFormatter.string(from: Date())
                        }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
