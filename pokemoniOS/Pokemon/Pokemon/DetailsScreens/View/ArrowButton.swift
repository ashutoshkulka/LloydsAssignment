//
//  ArrowButton.swift
//  Pokemon
//
//

import SwiftUI

enum ArrowDirection {
    case left
    case right
    case none
}

struct ArrowButton: View {
    var text: String
    var direction: ArrowDirection

    var body: some View {
        HStack(spacing: 12) {
            if direction == .left {
                Image.leftArrow
                Text(text)
                    .modifier(WhiteTitleTextModifier())
            } else if direction == .right {
                Text(text)
                    .modifier(WhiteTitleTextModifier())
                Image.rightArrow
            } else {
                Text(text)
                    .modifier(WhiteTitleTextModifier())
            }
        }
        .frame(width: 130)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(12)
    }
}

#if DEBUG
struct ArrowButton_Previews: PreviewProvider {
    @State static var tappedNextButton = false
    static var previews: some View {
        ArrowButton(text: "Charmeleon", direction: .left)
    }
}
#endif
