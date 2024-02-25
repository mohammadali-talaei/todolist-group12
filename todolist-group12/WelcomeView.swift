//
//  ContentView.swift
//  todolist-group12
//
//  Created by Mahyar Ghasemi Khah, and Mohammadali Talaei
//  Mahyar Ghasemi Khah: 101399392
//  Mohammadali Talaei: 101400831

import SwiftUI

struct WelcomeView: View {
    @State private var showSignIn = false
    var body: some View {
        VStack {
            Text("Mahyar Ghasemi Khah: 101399392")
            Text("Mohammadali Talaei: 101400831")
        }.padding()
        Spacer()
        VStack {
            Text("Task Master")
                .font(.system(size: 50))
                .bold()
                .tracking(5)
            Text("Managing your tasks effectively \n with Task Master")
                .frame(width: 600)
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.gray)
            Image("welcome-image")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("Enter", systemImage: "rectangle.portrait.and.arrow.right", action: {
                showSignIn = true
            })
                .fullScreenCover(isPresented: $showSignIn) {
                    SignInView()
                }
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
