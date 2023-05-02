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
        ZStack {
            Color(red: 147 / 255, green: 197 / 255, blue: 114 / 255)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image("logo")
                    .resizable()
                
                HStack {
                    Text("Подвиньте слайдер, как можно ближе к:")
                    
                    Text(targetValue.formatted())
                }

                HStack {
                    Text("0")
                    
                    UISliderRepresentation(
                        currentValue: $currentValue,
                        result: computeScore()
                    )
                    
                    Text("100")
                }
                
                Button("Проверь меня!", action: { isAlertPresented.toggle() })
                    .decor()
                    .alert(
                        "Ваш результат",
                        isPresented: $isAlertPresented,
                        actions: { }
                    ) {
                        Text("\(computeScore()) очков")
                    }
                
                Button("Начать заново", action: setNewValues)
                    .decor()
            }
            .padding()
        }

    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func setNewValues() {
        targetValue = Int.random(in: 0...100)
        currentValue = Double.random(in: 0...100)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 180, height: 50)
            .foregroundColor(.white)
            .font(.title2)
            .background(.purple)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 5)
    }
}

extension Button {
    func decor() -> some View {
        modifier(ButtonView())
    }
}
