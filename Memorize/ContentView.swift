//
//  ContentView.swift
//  Memorize
//
//  Created by Joqtan on 19/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {

    @State private var isFaceUp: Bool = true

    var body: some View {
    
        content
            .rotation3DEffect(
                .degrees(isFaceUp ? 0 : 180),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isFaceUp.toggle()
                }
            }
    }

    var frontView: some View {
        ZStack {
            BaseCard()
                .foregroundStyle(.white)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(.orange, lineWidth: 3))

            Text("🐲")
                .font(.largeTitle)
        }
    }

    var backView: some View {
        BaseCard()
    }

    @ViewBuilder
    var content: some View {
        if isFaceUp {
            frontView
        } else {
            backView

        }
    }
}

struct BaseCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
    }
}

#Preview {
    ContentView()
}
