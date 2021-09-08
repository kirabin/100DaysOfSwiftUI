//
//  ContentView.swift
//  WordScramble
//
//  Created by kirabin on 5.9.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var finishedWords: [String] = []
    @State private var finishedWordsCount: [Int] = []
    @State private var usedWords:[String] = []
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var showError = false
    @State private var errorMessage = ""
    @State private var errorTitle = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                List(finishedWords, id: \.self) { word in
                    Text(word)
                    Spacer()
                    Text("\(finishedWordsCount[finishedWords.firstIndex(of: word)!])")
                }
                
            }
            .navigationTitle(rootWord)
            .toolbar(content: {
                Button("Next", action: {
                    finishedWords.insert(rootWord, at: 0)
                    finishedWordsCount.insert(countScore(), at: 0)
                    startGame()
                })
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func countScore() -> Int {
        var count = 0
        
        for word in usedWords {
            count += word.count
        }
        return count
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard answer != rootWord else {
            wordError(title: "You can't use root word", message: "Try again")
            return
        }
        
        guard isPossible(answer) else {
            wordError(title: "Word is not possible", message: "Word should consist only of letters from the title  ")
            return
        }
        
        guard isOriginal(answer) else {
            wordError(title: "Word already used", message: "Try to use another one")
            return
        }
        
        guard isReal(answer) else {
            wordError(title: "This word doesn't exists", message: "We couldn't find this word in out database")
            return
        }
        
        
        
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        usedWords = []
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let words = startWords.components(separatedBy: "\n")
                
                rootWord = words.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word  {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        guard word.count > 1 else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
