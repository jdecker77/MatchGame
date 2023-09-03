//
//  ContentView.swift
//  MatchGame
//
//  Created by Jesse Decker on 8/25/23.
//

import SwiftUI

struct EmojiMatchGameView: View {
    @ObservedObject var viewModel: EmojiMatchGame

    @State var emojis: Array<String> = []
        
    var body: some View {
        VStack {
            Text("The Match Game!")
                .font(.largeTitle)
//            if emojis.count == 0{
//                instructions
//            }
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            themeSelection
        }
        .padding()
    }
    
    var instructions: some View {
        VStack {
            Text("Select A Theme to start the Match Game!")
                .foregroundColor(Color.orange)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    func setTheme(by theme: String, symbol: String, by emoji: [String]) -> some View {
        VStack {

            Button(action: {
                var paired_emoji: Array<String>
                paired_emoji = emoji+emoji
                emojis = paired_emoji.shuffled()
            }, label: {
                Image(systemName: symbol)
                    .frame(height: 20.0,alignment: .bottom)
                    .imageScale(.large)

            })
            Text(theme)
                .font(.caption)
                .foregroundColor(Color.blue)
        }
    }

    var theme1: some View {
        setTheme(by: "House Pets",symbol:"house",by: ["🐶","🐣","🐕‍🦺","🐠","🐹","🐛","🐩","🐸"])
    }

    var theme2: some View {
        setTheme(by: "Workers",symbol:"wrench.fill",by: ["🦄","🦜","🐴","🐔","🐐","🐂","🦆","🦚","🐖","🐏"])
    }

    var theme3: some View {
        setTheme(by: "Swimmers",symbol:"figure.open.water.swim",by: ["🦕","🦈","🐙","🦀","🐬","🐳","🐊","🦭","🦐","🦞","🐢","🪼"])
    }
    
    var themeSelection: some View {
        HStack {
            Spacer()
            theme1
            Spacer()
            theme2
            Spacer()
            theme3
            Spacer()
        
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing:0)],spacing:0) {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MatchGame<String>.Card
    
    init(_ card: MatchGame<String>.Card) {
        self.card = card
    }
    
//    let content: String
//    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size:200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMatchGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMatchGameView(viewModel: EmojiMatchGame())
    }
}
