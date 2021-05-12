//
//  ThemeEditorView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-05.
//

import SwiftUI

struct ThemeEditorView: View {
    @State private var name: String = ""
    @State private var emojiText: String = ""
    @State private var color: Color = .blue
    private var isEditing = false
    
    init(isEditing: Bool, theme: ThemeCollection.Theme) {
        self.name = theme.name
        self.color = Color(theme.accentColor)
        self.emojiText = theme.emojiSet.mergeIntoString()
    }
    init() { }
    
    @EnvironmentObject private var tcManager: ThemeCollectionManager
    @Environment(\.presentationMode) var presentation
    
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
            .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            presentation.wrappedValue.dismiss()
                            tcManager.addTheme(name: name, accentColor: UIColor(color), emojiSet: emojiText.splitIntoArrayOfString())
                        }.disabled(name == "" || emojiText.count < 2)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { presentation.wrappedValue.dismiss() }
                    }
            }
        }
    }
}


struct ThemeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditorView()
    }
}
