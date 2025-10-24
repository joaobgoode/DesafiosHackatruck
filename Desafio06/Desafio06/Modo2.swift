//
//  Modo2.swift
//  Desafio06
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct Modo2: View {
    
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fundo.ignoresSafeArea()
                VStack{
                    Text("Modo 2")
                        .font(.title)
                        .foregroundStyle(.white)
                        .bold()
                    Spacer()
                }
                VStack {
                    TextField("Nome", text: $name)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(width: 200)
                        .padding()
                    
                    Text("Bem vindo \(name == "" ? "" : ", \(name)")!")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                    Spacer()
                    
                    NavigationLink("Acessar Tela", destination: Modo2Nome(nome: name))
                        .padding()
                        .background(.botao2)
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 300, height: 240)
                .background(.botao)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    Modo2()
}
