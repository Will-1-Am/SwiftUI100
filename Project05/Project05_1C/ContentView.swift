//
//  ContentView.swift
//  WordScramble - Challenge 1 - Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
//
//  Created by William Spanfelner on 22/10/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: usedWords is an array of words, rootWord is the word from which the user needs to use to create new words, and newWord is the newly created word
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    
    // MARK: addNewWord() will provide the ability to submit entries from the TextField
    func addNewWord() {
        // MARK: newWord is made lowercased and trimmed of white space and line breaks
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // MARK: next the answer is checked for minimum characters
        guard answer.count > 0 else { return }
        
        //: Challenge 1 Check that our answer meets the minimum length
        guard meetsMinLength(word: answer) else {
            wordError(title: "Minimum word length", message: "Enter a word with at least three letters.")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't just make them up you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word does not exist", message: "That isn't a real word.")
            return
        }
        
        //: Challenge 1 Check that the answer is not simply the first three letters of the rootword
        guard isNotWordStart(word: answer) else {
            wordError(title: "Word length", message: "Short answer matches start of seed word. Make a longer word.")
            return
        }
        
        // MARK: insert the answer
        usedWords.insert(answer, at: 0)
        
        // MARK: reset the answer field
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // 2. Load start.txt into a String
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                // 3. Split the words up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one word randomly, or use silkworm as a default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                //If everything worked out it is time to exit
                return
            }
        }
        //If a problem occured it needs to be reported and crash the app
        fatalError("Could not load start.txt from bundle.")
    }
    
    //: Challenge 1 Return false if the answer word is 3 characters and matches the first three letters of the root word
    func isNotWordStart(word: String) -> Bool {
        if word.count == 3 && rootWord.hasPrefix(word) {
            return false
        }
        return true
    }
    
    //: Challenge 1 Return false if the answer word count is < 3 letters
    func meetsMinLength(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                // MARK:  .textFieldStyle(RoundedBorderTextFieldStyle()) and  .padding() help to improve contrast for the TextField
                    .autocapitalization(.none)
                // MARK: .autocapitalization(.none) will turn-off this TextField feature so that the user entries will look more consistent with the actual elements added to the used words list.
                
                
                // MARK: the SF font has a circled number character that can be used up to the number 20 and can be added as an image
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
                
        .navigationBarTitle(rootWord)
        .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
