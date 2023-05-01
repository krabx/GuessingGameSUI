//
//  UISliderRepresentation.swift
//  GuessingGameSUI
//
//  Created by Богдан Радченко on 01.05.2023.
//

import SwiftUI

struct UISliderRepresentation: UIViewRepresentable {
    @Binding var targetValue: Int
    @Binding var currentValue: Double
    let result: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.thumbTintColor = .red
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = Float(currentValue)
        
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .valueChanged)
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(currentValue)
        uiView.thumbTintColor = UIColor(red: 255 / 255, green: 0, blue: 0, alpha: Double(result) / 100)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(currentValue: $currentValue)
    }
}

extension UISliderRepresentation {
    final class Coordinator: NSObject {
        @Binding var currentValue: Double
        
        init(currentValue: Binding<Double>) {
            self._currentValue = currentValue
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            currentValue = Double(sender.value)
        }
    }
}

struct UISliderRepresentation_Previews: PreviewProvider {
    static var previews: some View {
        UISliderRepresentation(targetValue: .constant(50), currentValue: .constant(50), result: 50)
    }
}
