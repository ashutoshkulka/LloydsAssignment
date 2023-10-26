//
//  PopupView.swift
//  Pokemon
//
//

import SwiftUI

struct FilterView: View {

    @ObservedObject var viewModel: FilterViewModel
    @Binding var showPopup: Bool

    var body: some View {
        GeometryReader {proxy in
            ZStack(alignment: .center) {
                Color.screenBackground
                VStack {
                    VStack {
                        HStack(alignment: .top, spacing: 12) {
                            Text(Title.filters)
                                .modifier(TitleTextModifier())
                            Spacer()
                            Image.backButton
                                .resizable()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    showPopup = false
                                }
                        }
                        .foregroundColor(.black.opacity(0.7))

                        Divider().background(Color.black)
                    }
                    .padding()
                    ScrollView {
                        VStack {
                            ListFilterView(viewModel: viewModel.typeFilterListViewModel)
                            ListFilterView(viewModel: viewModel.genderFilterListViewModel)

                            Spacer()
                        }
                        StatFilterView(viewModel: viewModel.statFilterViewModel)
                    }
                    .padding(.horizontal, 3)

                    VStack {
                        Divider()
                            .background(Color.gray)
                        HStack {
                            Group {
                                ArrowButton(text: Title.reset, direction: .none)
                                    .onTapGesture {
                                        viewModel.resetAllFilters()
                                        showPopup = false
                                    }
                                ArrowButton(text: Title.apply, direction: .none)
                                    .onTapGesture {
                                        viewModel.updateAddedFiilter()
                                        showPopup = false
                                    }
                            }
                            .padding(.vertical, 12)
                        }
                    }
                    .shadow(color: .black, radius: 2)
                }
                .frame(width: proxy.size.width - 50, height: proxy.size.height - 50)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 20)
            }
            .ignoresSafeArea()
        }
    }
}

#if DEBUG
struct FilterView_Previews: PreviewProvider {
    @State static var showPopup = true
    static var previews: some View {
        FilterView(viewModel: FilterViewModel(filter: Filter()), showPopup: $showPopup)
    }
}
#endif
