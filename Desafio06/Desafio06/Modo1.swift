//
//  Modo1.swift
//  Desafio06
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct Modo1: View {
    var body: some View {
        ZStack{
            Color.fundo.ignoresSafeArea()
            VStack{
                    Text("Modo 1")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
            }
            VStack {
                Text("Nome: João Victor")
                Text("Sobrenome: Vieira Marcondes")
            }
            .padding(40)
            .background(.botao)
            .cornerRadius(10)
            .foregroundColor(.white)
            .bold()
        }
    }
}

#Preview {
    Modo1()
}
