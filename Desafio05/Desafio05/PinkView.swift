//
//  PinkView.swift
//  Desafio05
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct PinkView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush")
                .resizable()
                .scaledToFit()
                .padding(40)
                .foregroundColor(.pink)
                .frame(width: 300)
                .background(Circle().fill(.black))
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.pink)
    }
}

#Preview {
    PinkView()
}
