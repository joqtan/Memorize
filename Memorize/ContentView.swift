//
//  ContentView.swift
//  Memorize
//
//  Created by Joqtan on 19/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let cards: [String] = [
            "🎃",
            "👻",
            "🦇",
            "🧛‍♂️",
            "🧌",
            "🧟"
        ]

        HStack {
            ForEach( cards.shuffled(), id: \.self ) { emoji in
                CardView(content: emoji)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {

    let content: String

    @State private var isFaceUp: Bool = true

    var body: some View {

        card
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
                .overlay(
                    RoundedRectangle(cornerRadius: 12).stroke(
                        .orange, lineWidth: 3))

            Text(content)
                .font(.largeTitle)
        }
    }

    var backView: some View {
        BaseCard()
    }

    @ViewBuilder
    var card: some View {
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
