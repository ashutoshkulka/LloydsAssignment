//
//  LinearProgressBarView.swift
//  PokemonUIComponents
//
//

import SwiftUI

struct LinearProgressBarView: View {
    @Binding var value: Int
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .foregroundColor(.gray)
                Rectangle()
                    .frame(width: proxy.size.width * CGFloat(value)/210, height: proxy.size.height)
                    .foregroundColor(.black)
                Text("\(value)")
                    .foregroundColor(.white)
                    .padding(.leading, 8)
            }
        }
    }
}

#if DEBUG
struct LinearProgressBarView_Previews: PreviewProvider {
    @State static var value = 80
    static var previews: some View {
        LinearProgressBarView(value: $value)
                .frame(width: 300, height: 20)
    }
}
#endif
