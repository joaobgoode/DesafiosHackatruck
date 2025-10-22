//
//  ContentView.swift
//  Desafio03
//
//  Created by Turma01-8 on 22/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = "fulano"
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Image("Image")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
                .ignoresSafeArea()
                .frame(width: 40)
            
            VStack(spacing: 20) {
                Text("Bom dia, \(name.count != 0 ? name : "Visitante")")
                    .font(.title)
                    .fontWeight(.semibold)
                
                TextField("Nome", text: $name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                Button("Entrar") {
                    showingAlert = true
                }
            }
            .padding()
        }
        .alert("ALERTA !", isPresented: $showingAlert) {
            Button("Vamos lá!"){
                showingAlert = false
            }
        } message: {
            Text("Você irá iniciar o desafio de aula agola")
        }
    }
}


#Preview {
    ContentView()
}
