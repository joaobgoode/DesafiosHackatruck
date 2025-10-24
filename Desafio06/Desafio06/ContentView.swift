//
//  ContentView.swift
//  Desafio06
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sheetShowing = false
    
    var body: some View {
            NavigationStack{
                ZStack{
                    VStack{
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        NavigationLink(destination: Modo1()){
                            Text("Modo 1")
                        }
                        .foregroundColor(.white)
                        .frame(width: 230, height: 90)
                        .background(.botao)
                        .cornerRadius(10)
                        
                        NavigationLink(destination: Modo2()){
                            Text("Modo 2")
                        }
                        .foregroundColor(.white)
                        .frame(width: 230, height: 90)
                        .background(.botao)
                        .cornerRadius(10)
                        
                        Button("Modo 3"){
                            sheetShowing = true
                        }
                        .foregroundColor(.white)
                        .frame(width: 230, height: 90)
                        .background(.botao)
                        .cornerRadius(10)
                        .sheet(isPresented: $sheetShowing) {
                            Modo3()
                        }
                        Spacer()
                    }
                    
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                    .background(.fundo)
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    ContentView()
}
