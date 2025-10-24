//
//  Desafio05App.swift
//  Desafio05
//
//  Created by Turma01-8 on 24/10/25.
//

import SwiftUI

@main
struct Desafio05App: App {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
