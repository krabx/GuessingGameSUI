//
//  ContentView.swift
//  GuessingGameSUI
//
//  Created by Богдан Радченко on 01.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = Double.random(in: 0...100)
    @State private var isAlertPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Подвиньте слайдер, как можно ближе к: ")
                
                Text(targetValue.formatted())
            }

            HStack {
                Text("0")
                
                UISliderRepresentation(
                    targetValue: $targetValue,
                    currentValue: $currentValue,
                    result: computeScore()
                )
                
                Text("100")
            }
            
            Button("Проверь меня!", action: { isAlertPresented.toggle()})
                .alert("Ваш результат", isPresented: $isAlertPresented, actions: { }) {
                    Text("\(computeScore()) очков")
                }
            
            Button("Начать заново", action: setNewTargetValue)
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func setNewTargetValue() {
        targetValue = Int.random(in: 0...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
