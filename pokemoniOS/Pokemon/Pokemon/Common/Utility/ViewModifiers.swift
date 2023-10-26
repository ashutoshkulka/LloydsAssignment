//
//  ViewModifiers.swift
//  Pokemon
//
//

import Foundation
import SwiftUI

struct LargeTitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitleText)
            .foregroundColor(.black)
            .fontWeight(.heavy)
    }
}

struct TitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.titleText)
            .foregroundColor(.black)
            .fontWeight(.heavy)
    }
}

struct TitleTextModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.titleText2)
            .foregroundColor(.black)
            .fontWeight(.bold)
    }
}

struct SubTitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.titleText)
            .fontWeight(.thin)
            .foregroundColor(.titleText)
    }
}

struct WhiteTitleTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.titleText)
            .fontWeight(.thin)
            .foregroundColor(.white)
    }
}
