//
//  FlashCardView.swift
//  Flashy
//
//  Created by Artem on 2023-06-07.
//

import SwiftUI

struct FlashCardView: View {
    let card: Flashcard
    var removal: (() -> Void)? = nil
    @State private var isShown = false
    @State private var offset = CGSize.zero
    @State private var offsetY = CGSize.zero
    @State private var slide = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 3)
            
            VStack {
                Text(card.question)
                    .foregroundColor(.black)
                    .font(.title)
                // Making the answer invisible until tapped
                if isShown {
                    Text(card.answer)
                        .foregroundColor(.black)
                        .font(.title3)
                        .offset(y: 100)
                }
            }
            
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 330, height: 550)
        .rotationEffect(.degrees(Double(offset.width / 5)))
       
        // makes an effect when swiping the card and it gets back if swipped not too much
        .offset(x: offset.width * 5, y: offsetY.height * 5) // changes the position of the card by x - direction
        .opacity(2 - Double(abs(offset.width / 50))) //adds an opacity for width / 50
        .opacity(2 - Double(abs(offset.height / 50)))
            .onTapGesture {
                isShown.toggle()
            }
        .gesture(
            DragGesture().onChanged { value in
                offset = value.translation
                offsetY = value.translation
            }
            .onEnded { value in
                if abs(offset.width) > 100 {
                    withAnimation {
                        offset.width = value.translation.width > 0 ? 1000 : -1000
                        removal?()
                    }
                } else if abs(offsetY.height) > 100 {
                    withAnimation {
                        offsetY.height = value.translation.height > 0 ? 1000 : -1000
                        removal?()
                    }
                } else {
                    offset = .zero
                    offsetY = .zero
                }
            }

                
        )
        
        
    }
}

struct FlashCardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashCardView(card: Flashcard(question: "Sample Question", answer: "Sample Answer"))
    }
}
