//
//  ContentView.swift
//  Desafio11
//
//  Created by Turma01-8 on 03/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var categoriasRepo = CategoriaRepository()
    @StateObject var itemsRepo = ItemRepository()
    
    @State var cardapio: Categoria = Categoria(
        parent_id: -1,
        id: 0,
        nome: "Cardápio",
        itens: [],
        subcategorias: [],
        image: "https://thumbs.dreamstime.com/b/personagem-de-chef-desenho-animado-com-logotipo-bandeja-emblema-para-design-card%C3%A1pio-restaurante-ou-caf%C3%A9-ilustra%C3%A7%C3%A3o-vetorial-244284328.jpg"
    )
    
    var body: some View {
        ZStack {
            Color.fundo.ignoresSafeArea()
            VStack {
                Image("Caminhao")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .padding()
                Text("Bar do Hacka")
                    .font(.title)
                    .bold()
                CategoriaView(categoria: cardapio)
                Spacer()
            }
            .onAppear {
                categoriasRepo.fetch()
                itemsRepo.fetch()
            }
            .onChange(of: categoriasRepo.categorias) {
                atualizarCardapio(categorias: $0, items: itemsRepo.items)
            }
            .onChange(of: itemsRepo.items) {
                atualizarCardapio(categorias: categoriasRepo.categorias, items: $0)
            }
        }
    }
    
    func atualizarCardapio(categorias: [Categoria], items: [Item]) {
        var novasCategorias = categorias
        
        for i in 0..<novasCategorias.count {
            novasCategorias[i].getSubcategorias(categorias: novasCategorias)
            novasCategorias[i].getItems(items: items)
        }
        
        var novoCardapio = cardapio
        novoCardapio.getSubcategorias(categorias: novasCategorias)
        novoCardapio.getItems(items: items)
        
        cardapio = novoCardapio
    }
}

#Preview {
    ContentView()
}
