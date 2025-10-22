//
//  ContentView.swift
//  Desafio02
//
//  Created by Turma01-8 on 22/10/25.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
              Image("Hacka")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding()
                Spacer()
                VStack{
                    Text("Hackatruck").foregroundStyle(.red)
                    Text("77 Universidades").foregroundStyle(.blue)
                        .padding(5)
                    Text("5 regiões do Brasil").foregroundStyle(.yellow)
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
