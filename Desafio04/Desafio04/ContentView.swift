//
//  ContentView.swift
//  Desafio04
//
//  Created by Turma01-8 on 23/10/25.
//

import SwiftUI

func getImage(vel: Double) -> String {
    switch vel {
    case ...0: return "interrogacao"
    case 0..<10: return "tartaruga"
    case 10..<30: return "elefante"
    case 30..<70: return "avestruz"
    case 70..<90: return "leao"
    case 90...130: return "guepardo"
    default: return "interrogacao"
    }
}

func getColor(vel: Double) -> Color {
    switch vel {
    case ...0: return .gray
    case 0..<10: return .verde
    case 10..<30: return .azulClaro
    case 30..<70: return .laranja
    case 70..<90: return .amarelo
    case 90...130: return .vermelho
    default: return .gray
    }
}

func getRotationSpeed(vel: Double) -> Double {
    switch vel {
    case ...0: return 0
    case 0..<10: return 20
    case 10..<30: return 15
    case 30..<70: return 10
    case 70..<90: return 7
    case 90...130: return 3
    default: return 0
    }
}


func linhaLegenda(animal: String, min: Int, max: Double, color: Color) -> some View{
    return HStack{
        Text(animal)
            .frame(width: 100)
        Spacer()
        Text("(\(min) - \(String(format: "%.1f km/h", max).replacingOccurrences(of: ".", with: ",")))")
            .frame(width: 150)
        Circle()
            .fill(color)
            .frame(width: 10, height: 10)
    }
}




struct ContentView: View {
    @State private var dist: Double = 0
    @State private var tempo: Double = 0
    @State private var vel: Double = 0
    @State private var angle: Double = 0.0
    @State private var timer: Timer? = nil

    
    func startRotation() {
        timer?.invalidate()
        let speed = getRotationSpeed(vel: vel)
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true) { _ in
                if vel <= 0 || vel > 130 {
                    angle = 0
                } else {
                    angle += 360 / (speed * 100)
                    if angle >= 360 {
                        angle -= 360
                    }
                }
                

        }
    }
    
    var body: some View {
        
        
        
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text("Digite a Distância(km)")
                TextField("distancia", value: $dist, format: .number)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 200)
                Text("Digite o tempo(h)")
                TextField("Tempo", value: $tempo, format: .number)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .frame(width: 200)
                
                Button("Calcular") {
                    if tempo == 0 {
                        vel = 0
                    } else {
                        vel = dist / tempo
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .foregroundColor(.orange)
            }

            Text("\(String(format: "%.2f km/h", vel).replacingOccurrences(of: ".", with: ","))")
                .font(.title)
            Image(getImage(vel: vel))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(angle))
                .onChange(of: vel, initial: false) {
                    startRotation()
                }
            
            VStack(spacing: 0) {
                linhaLegenda(animal: "TARTARUGA", min: 0, max: 9.9, color: .verde)
                linhaLegenda(animal: "ELEFANTE", min: 10, max: 29.9, color: .azulClaro)
                linhaLegenda(animal: "AVESTRUZ", min: 30, max: 69.9, color: .laranja)
                linhaLegenda(animal: "LEAO", min: 70, max: 89.9, color: .amarelo)
                linhaLegenda(animal: "GUEPARDO", min: 90, max: 130, color: .laranja)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15) // 👈 borda arredondada
                    .fill(Color.black)
            )
            .foregroundColor(.white)
            .frame(width: 300)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getColor(vel: vel))
    }
}

#Preview {
    ContentView()
}
