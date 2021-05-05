//
//  ThemeSelectionView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-04.
//

import SwiftUI

struct ThemeSelectionView: View {
    @State private var showingPopover = false
    @ObservedObject var themes: ThemeSet
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(themes.getThemeSet()) { theme in
                    NavigationLink(destination: DestinationPageView(theme: theme)) {
                        HStack {
                            Image(systemName: "chevron.right.circle.fill")
                                .foregroundColor(theme.accentColor)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(theme.themeName)
                                Text(theme.emojiSet.joined(separator: " "))
                            }.font(.headline).padding()
                        }
                    }
                }.onDelete(perform: onDelete)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Themes")
            .navigationBarItems(trailing: HStack {
                //Button(action: {self.showingPopover = true}, label: {Image(systemName: "pencil").resizable().frame(width: 20, height: 20)})
                //EditButton().padding(5)
                Button(action: {self.showingPopover = true}, label: {Image(systemName: "plus")}).padding(5)//.resizable().frame(width: 20, height: 20)
            }
            .sheet(isPresented: $showingPopover) {
                    ThemeEditorView { name,accentColor,emojiSet  in
                    themes.addTheme(name: name, accentColor: accentColor, emojiSet: emojiSet)
                    }
            }
            ).environment(\.editMode, $editMode)
        }
    }
    private func onDelete(offsets: IndexSet) {
        themes.themeSet.remove(atOffsets: offsets)
    }
}
struct DestinationPageView: View {
    var theme: Theme
    var viewModel: EmojiMemoryGameViewModel
    
    init(theme: Theme) {
        self.theme = theme
        self.viewModel = EmojiMemoryGameViewModel(theme: theme)
    }

    var body: some View {
        viewModel.resetGame()
        return EmojiMemoryGameView(viewModel: viewModel)
    }
}

struct ThemeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelectionView(themes: ThemeSet())
    }
}
