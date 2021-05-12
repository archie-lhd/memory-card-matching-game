//
//  ThemeEditorView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-05.
//

import SwiftUI

struct ThemeEditorView: View {
    @EnvironmentObject private var tcManager: ThemeCollectionManager
    @Environment(\.presentationMode) var presentation
    private var isEditing: Bool
    private var selectedTheme: ThemeCollection.Theme?
    @State private var name: String
    @State private var emojiText: String
    @State private var color: Color
    
    init(theme: ThemeCollection.Theme) {
        self.isEditing = true
        self.selectedTheme = theme
        self._name = State(wrappedValue: theme.name)
        self._color = State(wrappedValue: Color(theme.accentColor))
        self._emojiText = State(wrappedValue: theme.emojiSet.mergeIntoString())
    }
    init() {
        self.isEditing = false
        self._name = State(initialValue: "")
        self._color = State(initialValue: Color(.blue))
        self._emojiText = State(initialValue: "")
    }
    
    
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
                        Button(isEditing ? "Done" : "Add") {
                            presentation.wrappedValue.dismiss()
                            if isEditing {
                                tcManager.editTheme(
                                    id: selectedTheme!.id,
                                    name: name,
                                    accentColor: UIColor(color),
                                    emojiSet: emojiText.splitIntoArrayOfString()
                                )
                            } else {
                                tcManager.addTheme(
                                    name: name,
                                    accentColor: UIColor(color),
                                    emojiSet: emojiText.splitIntoArrayOfString()
                                )
                            }
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
