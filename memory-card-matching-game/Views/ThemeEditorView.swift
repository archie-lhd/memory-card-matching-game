//
//  CustomizeThemeView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-05.
//

import SwiftUI

struct ThemeEditorView: View {
    @State private var name: String = ""
    @State private var emojiText: String = ""
    @State private var color: Color = .blue
    
    @Environment(\.presentationMode) var presentation
    
    var updateChanges: (_ name: String, _ accentColor: Color, _ emojiSet: Array<String>) -> Void
    var body: some View {
        NavigationView {
            List {
                Section {
                    ColorPicker("Color", selection: $color)
                }
                Section() {
                    HStack {
                        Text("Name\t")
                        TextField("New Theme", text: $name)
                    }
                    HStack {
                        Text("Emojis\t")
                        TextField("Enter your Emojis", text: $emojiText)
                    }
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentation.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    updateChanges(name, color, emojiText.splitIntoArrayOfString())
                    presentation.wrappedValue.dismiss()
                }.disabled(name == "" || emojiText.count < 2)
            )
        }
    }
}
//
//struct CustomizeThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeCustomizationView()
//    }
//}
