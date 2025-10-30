//
//  DetalhesCardView.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import SwiftUI

struct DetalhesCardView: View {
    var detalhes: Detalhes
    var body: some View {
        VStack {
//            HStack {
//                Text("Tipo de Veiculo")
//                    .bold()
//                Spacer()
//                Text("\(detalhes.TipoVeiculo ?? 0)")
//            }
//            Divider()
            HStack {
                Text("Marca")
                    .bold()
                Spacer()
                Text("\(detalhes.Marca ?? "")")
            }
            Divider()
            HStack {
                Text("Modelo")
                    .bold()
                Spacer()
                Text("\(detalhes.Modelo ?? "")")
            }
            Divider()
            HStack {
                Text("Ano Modelo")
                    .bold()
                Spacer()
                Text("\(detalhes.AnoModelo ?? 0)")
            }
            Divider()
            HStack {
                Text("Valor")
                    .bold()
                Spacer()
                Text("\(detalhes.Valor ?? "")")
            }
            Divider()
            HStack {
                Text("Combustivel")
                    .bold()
                Spacer()
                Text("\(detalhes.Combustivel ?? "")")
            }
            Divider()
            HStack {
                Text("Sigla Combustivel")
                    .bold()
                Spacer()
                Text("\(detalhes.SiglaCombustivel ?? "")")
            }
            
            Divider()
            HStack {
                Text("Codigo FIPE")
                    .bold()
                Spacer()
                Text("\(detalhes.CodigoFipe ?? "")")
            }
            Divider()
            
            HStack {
                Text("Mes de Referência")
                    .bold()
                Spacer()
                Text("\(detalhes.MesReferencia ?? "")")
            }
            
        }
        .padding()
    }
}


#Preview {
    DetalhesCardView(detalhes: Detalhes(
        TipoVeiculo: 1,
        Valor: "R$ 50.000",
        Marca: "Volkswagen",
        Modelo: "Gol",
        AnoModelo: 2023,
        Combustivel: "Gasolina",
        CodigoFipe: "001234-5",
        MesReferencia: "Outubro/2025",
        SiglaCombustivel: "G"
    ))
}
