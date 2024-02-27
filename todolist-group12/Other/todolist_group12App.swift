//
//  todolist_group12App.swift
//  todolist-group12
//
//  Created by developer-rapidcents on 2024-02-24.
//
import SwiftUI
import FirebaseCore

@main
struct todolist_group12App: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
