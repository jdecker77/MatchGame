//
//  ContentView.swift
//  MatchGame
//
//  Created by Jesse Decker on 8/25/23.
//

import SwiftUI

struct ContentView: View {

    @State var emojis: Array<String> = []
        
    var body: some View {
        VStack {
            Text("The Match Game!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeSelection
        }
        .padding()
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
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
