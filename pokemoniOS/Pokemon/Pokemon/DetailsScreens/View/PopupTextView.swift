//
//  PopupView.swift
//  Pokemon
//
//

import SwiftUI

struct PopupTextView: View {
    @State var text: String
    @Binding var showPopup: Bool
    var body: some View {
        HStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text(text)
                        .font(.titleText)
                        .foregroundColor(.white)
                }
            }
            Text(Constants.xImage)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation {
                        showPopup.toggle()
                    }
                }
        }
        .padding()
        .frame(width: 280, height: 400)
        .background(Color.popupBackground)
        .cornerRadius(20)
        .shadow(radius: 20 )
    }
}

#if DEBUG
struct PopupView_Previews: PreviewProvider {
    @State static var text: String = "Text"
    @State static var showPopup = true

    static var previews: some View {
        PopupTextView(text: text, showPopup: $showPopup)
    }
}
#endif
