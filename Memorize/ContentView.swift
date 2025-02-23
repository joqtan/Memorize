//
//  ContentView.swift
//  Memorize
//
//  Created by Joqtan on 19/2/25.
//

import SwiftUI

struct ContentView: View {

    let emojis: [String] = [
        "🎃", "👻", "🦇", "🧛", "🧌", "🧟", "🕷️", "🦉", "🪦", "💀", "🩸", "🔪", "🕯️", "📖",
        "🔮", "🧙", "🪄", "🐺",
    ]

    @State private var cardCount: Int = 10

    var body: some View {

        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardAjusters

        }.padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
                .font(.largeTitle)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    var cardAjusters: some View {
        HStack {
            cardCountAdjuster(
                by: -1, symbol: "rectangle.stack.fill.badge.minus")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
        }.padding()
    }

}

struct CardView: View {

    let content: String

    @State private var isFaceUp: Bool = true

    var body: some View {

        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(style: StrokeStyle(lineWidth: 1))
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

        }
        .rotation3DEffect(
            .degrees(isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .onTapGesture {
            withAnimation {
                self.isFaceUp.toggle()
            }
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
