//
//  CheckBoxView.swift
//  Pokemon
//
//

import SwiftUI

struct CheckBoxView: View {
    var title: String
    @Binding var isChecked: Bool
    var body: some View {
        HStack {
            (isChecked ? Image.checkedCheckBox: Image.uncheckedCheckBox)
                .onTapGesture {
                    isChecked.toggle()
                }
            Text(title.capitalized)
                .modifier(SubTitleTextModifier())
            Spacer()
        }
        .padding(.all, 0)
    }
}

#if DEBUG
struct CheckBoxView_Previews: PreviewProvider {
    @State static var value: Bool = false
    static var previews: some View {
        CheckBoxView(title: "Normal", isChecked: $value)
    }
}
#endif
