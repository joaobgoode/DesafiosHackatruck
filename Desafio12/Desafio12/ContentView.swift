//
//  ContentView.swift
//  Desafio12
//
//  Created by Turma01-8 on 04/11/25.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    let model = GenerativeModel(
        name: "gemini-2.5-flash",
        apiKey: APIKey.default
    )
    
    @State private var textInput = ""
    @State private var aiResponse = ""
    @State private var asked = false
    @State private var isLoading = false
    
    func sendMessage() {
        
        let promptSetUp = "Essa é a minha viagem dos sonos, me indique um local para ir, me de o nome da cidade, pais, me de 5 razoes para ir para la com breves frases, cada uma com umas 5-7 palavras: "
        aiResponse = ""
        isLoading = true
        
        Task {
            do {
                let response = try await model.generateContent(promptSetUp + textInput)
                guard let text = response.text else {
                    aiResponse = "Não consegui processar sua solicitação. Tente novamente."
                    return
                }
                aiResponse = text
            } catch {
                aiResponse = "Ocorreu um erro:\n\(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("🌍 Viagem dos Sonhos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                
                if !asked {
                    VStack(spacing: 20) {
                        Text("Descreva sua viagem dos sonhos e nós lhe diremos para onde ir!")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        TextField("Digite aqui...", text: $textInput)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .frame(height: 60)
                        
                        Button(action: {
                            sendMessage()
                            asked.toggle()
                        }) {
                            Label("Perguntar", systemImage: "questionmark.bubble.fill")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                } else {
                    VStack(spacing: 20) {
                        if isLoading {
                            ProgressView("Gerando resposta...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                                .padding()
                        } else {
                            ScrollView {
                                Text(aiResponse)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                        }
                        
                        Button(action: {
                            textInput = ""
                            aiResponse = ""
                            asked.toggle()
                        }) {
                            Label("Fazer outra pergunta", systemImage: "arrow.counterclockwise")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
