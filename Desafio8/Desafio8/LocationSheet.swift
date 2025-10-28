//
//  LocationSheet.swift
//  Desafio10
//
//  Created by Turma01-8 on 28/10/25.
//

import SwiftUI

struct LocationSheet: View {
    var location: Location

    var body: some View {
        ZStack {
            Color.fundo.ignoresSafeArea()
            VStack {
                Image(location.foto)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
                    .clipped()
                    .frame(width: 320, height: 220)
                    .border(.brown, width: 2)

                Text(location.nome)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .foregroundColor(.brown)
                
                ScrollView{
                    Text(location.descricao)
                        .font(.title3)
                        .padding()
                }
                .frame(width: 320, height: 400)
                .background(.brown)
                
            }
        }
    }
}

#Preview {
    LocationSheet(location: Location(
        nome: "Coliseu de Roma",
        foto: "coliseu",
        descricao: "O Coliseu, localizado em Roma, é um anfiteatro monumental construído no século I d.C. e considerado um dos maiores símbolos da engenharia e da cultura do Império Romano. Com capacidade para mais de 50.000 espectadores, era palco de batalhas de gladiadores, espetáculos e eventos públicos. Sua estrutura elíptica, com arcadas imponentes e sistemas complexos de circulação e elevadores, reflete a genialidade arquitetônica romana, tornando-o um dos monumentos mais visitados e admirados do mundo.",
        latitude: 41.890251,
        longitude: 12.492373
    ))
}
