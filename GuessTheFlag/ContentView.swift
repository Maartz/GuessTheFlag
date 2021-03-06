//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by William Martin on 23/11/2020.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var userScore = 0
  
  var body: some View {
    ZStack{
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
      VStack(spacing: 30){
        VStack{
          Text("Tap the flag of")
            .font(.title)
          Text(countries[correctAnswer])
            .font(.largeTitle)
            .fontWeight(.black)
        }.foregroundColor(.white)
        
        ForEach(0..<3) { number in
          Button(action: {
            self.flagTapped(number)
          }) {
            FlagImage(country: self.countries[number])
          }
        }
        Spacer()
        VStack {
          Text("Score: \(userScore)")
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)

        }
        Spacer()
      }
    }
    .alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle),
            message:Text("Your score is \(userScore)"),
            dismissButton: .default(Text("Continue")) {
              self.askQuestion()
            })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      userScore += 1
      scoreTitle = "Correct"
    } else {
      scoreTitle = "Wrong, that's the flag of \(countries[number])"
    }
    showingScore = true
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

struct FlagImage: View {
  var country: String
  var body: some View {
    Image(country)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color:.black, radius: 2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
