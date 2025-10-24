//
//  Modo2Nome.swift
//  Desafio06
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct Modo2Nome: View {
    var nome: String = "Visitante"
    var body: some View {
        ZStack{
            Color.fundo.ignoresSafeArea()
            VStack{
                Text("Modo 2")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                Spacer()
            }
            VStack{
                Text("Volte,\n\(nome)!!")
            }
            .bold()
            .font(.title2)
            .foregroundColor(.white)
            .padding(.horizontal)
            .padding()
            .background(.botao)
            .cornerRadius(10)
        }
    }
}

#Preview {
    Modo2Nome()
}
