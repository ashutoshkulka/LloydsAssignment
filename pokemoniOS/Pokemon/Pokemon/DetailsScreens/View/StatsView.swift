//
//  StatsView.swift
//  Pokemon
//
//

import SwiftUI

struct StatsView: View {

    @ObservedObject var viewModel: StatViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(Title.stats)
                .modifier(TitleTextModifier2())
            ForEach($viewModel.stats, id: \.name) {stat in
                statView(name: stat.name.wrappedValue, stat: stat.value)
            }
        }
        .padding(.all, 40)
        .background(Color.statsBackground)
    }

    @ViewBuilder func statView(name: String, stat: Binding<Int>) -> some View {
        HStack {
            Text(name)
                .modifier(TitleTextModifier())
                .frame(width: 100)
            LinearProgressBarView(value: stat)
                .frame(height: 15)
        }
    }
}

#if DEBUG
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(viewModel: StatViewModel(stats: [Stat(name: "hp", value: 56)]))
    }
}
#endif
