//
//  BlueView.swift
//  Desafio05
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

struct BlueView: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush.pointed")
                .resizable()
                .scaledToFit()
                .padding(40)
                .foregroundColor(.blue)
                .frame(width: 300)
                .background(Circle().fill(.black))
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.blue)
    }
}

#Preview {
    BlueView()
}
