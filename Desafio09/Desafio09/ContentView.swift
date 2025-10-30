//
//  ContentView.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import SwiftUI

protocol Item: Equatable {
    var nome: String { get }
    func filtered(_ substring: String) -> Bool
}

extension Item {
    func filtered(_ substring: String) -> Bool {
        substring.isEmpty || nome.lowercased().contains(substring.lowercased())
    }
}


enum ListDataType {
    case marca
    case modelo
    case ano
    case detalhes
}

struct ContentView: View {
    
    @StateObject var marcaModel = MarcaModel()
    @StateObject var modelosView = ModeloView()
    @StateObject var anosView = AnosView()
    @StateObject var detalhesView = Detalhesview()
    
    @State private var currentList: ListDataType = .marca
    @State private var selectedMarca: Marca? = nil
    @State private var selectedModelo: Modelo? = nil
    @State private var selectedAno: Ano? = nil
    
    
    @State private var filterMarca = ""
    @State private var filterModelo = ""
    @State private var filterAno = ""
    
    @State private var filteredMarca: [Marca] = []
    @State private var filteredModelo: [Modelo] = []
    @State private var filteredAno: [Ano] = []
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .background(.white)
            if currentList != ListDataType.marca {
                HStack {
                    Button("Voltar", systemImage: "arrow.backward") {
                        if currentList == .ano {
                            currentList = .modelo
                            filterAno = ""
                        } else if currentList == .modelo {
                            currentList = .marca
                            filterModelo = ""
                        } else if currentList == .detalhes {
                            currentList = .ano
                        }
                    }
                    .padding()
                    Spacer()
                }
                .foregroundColor(.blue)
            }
            
            if currentList != .marca{
                Text(selectedMarca!.nome)
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .bold()
                
                if currentList != .modelo {
                    Text(selectedModelo!.nome)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .bold()
                    
                    if currentList != .ano {
                        Text(selectedAno!.nome)
                            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            .bold()
                    }
                }
            }
            
            if currentList == .marca {
                TextField("", text: $filterMarca)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                List(filteredMarca) { marca in
                    Button(action: {
                        selectedMarca = marca
                        modelosView.fetch(codigo: marca.codigo)
                        filteredModelo = modelosView.modelos
                        currentList = .modelo
                    }) {
                        Text(marca.nome)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(.plain)
                .animation(nil, value: currentList)
            }
            
            if currentList == .modelo {
                
                TextField("", text: $filterModelo)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                List(filteredModelo) { modelo in
                    Button(action: {
                        if let marca_id = selectedMarca?.codigo {
                            selectedModelo = modelo
                            anosView.fetch(marca_id: marca_id, modelo_id: modelo.codigo)
                            currentList = .ano
                        }
                    }) {
                        Text(modelo.nome)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(.plain)
                .animation(nil, value: currentList)
            }
            
            if currentList == .ano {
                TextField("", text: $filterAno)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                List(filteredAno) { ano in
                    Button(action: {
                        selectedAno = ano
                        if let marca_id = selectedMarca?.codigo,
                           let modelo_id = selectedModelo?.codigo {
                            detalhesView.fetch(
                                marca_id: marca_id,
                                modelo_id: modelo_id,
                                ano_id: ano.codigo)
                            currentList = .detalhes
                        }
                    }) {
                        Text(ano.nome)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(.plain)
                .animation(nil, value: currentList)
                
            }
            if currentList == .detalhes {
                VStack {
                    DetalhesCardView(detalhes: detalhesView.detalhes)
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .padding()
        .onAppear {
            marcaModel.fetch()
            filteredMarca = marcaModel.marcas
        }
        
        .onChange(of: filterMarca){
            filteredMarca = marcaModel.marcas.filter({$0.filtered(filterMarca)})
        }
        .onChange(of: filterModelo){
            filteredModelo = modelosView.modelos.filter({$0.filtered(filterModelo)})
        }
        .onChange(of: filteredAno){
            filteredAno = anosView.anos.filter({$0.filtered(filterAno)})
        }
        .onChange(of: marcaModel.marcas) {
            if filterMarca.isEmpty {
                filteredMarca = marcaModel.marcas
            }
        }
        .onChange(of: modelosView.modelos) {
            if filterModelo.isEmpty {
                filteredModelo = modelosView.modelos
            }
        }
        .onChange(of: anosView.anos) {
            if filterAno.isEmpty {
                filteredAno = anosView.anos
            }
        }
    }
}

#Preview {
    ContentView()
}
