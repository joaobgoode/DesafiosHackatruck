//
//  ContentView.swift
//  Desafio01
//
//  Created by Turma01-8 on 22/10/25.
//

import SwiftUI


func Square(side: Int, color: Color) -> some View {
    Rectangle()
        .fill(color)
        .frame(width: CGFloat(side), height: CGFloat(side))
}

struct ContentView: View {
    
    var body: some View {
        VStack{
            HStack {
                Square(side: 110, color: .red)
                Spacer()
                Square(side: 110, color: .blue)
            }
            Spacer()
            HStack(){
                Square(side: 110, color: .green)
                Spacer()
                Square(side: 110, color: .yellow)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
