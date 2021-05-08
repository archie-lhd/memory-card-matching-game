//
//  ThemeSelectionView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-04.
//

import SwiftUI

struct ThemeSelectionView: View {
    @State private var showingSheet = false
    @ObservedObject var tcManager: ThemeCollectionManager
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(tcManager.themes) { theme in
                    NavigationLink(destination: DestinationPageView(theme: theme)) {
                        HStack {
                            Image(systemName: "chevron.right.circle.fill")
                                .foregroundColor(Color(theme.accentColor))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(theme.name)
                                Text(theme.emojiSet.joined(separator: " "))
                            }.font(.headline).padding()
                        }
                    }
                }.onDelete(perform: onDelete)
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem() {
                    HStack {
                        // EditButton()
                        Button(action: { self.showingSheet = true }, label: {Image(systemName: "plus")})
                    }
                }
            }.environment(\.editMode, $editMode)
            .navigationTitle("Themes")
            
            DestinationPageView(theme: DefaultThemes.theme1)
            // Text("⬅️Select your theme from sidebar")
        }
        .sheet(isPresented: $showingSheet) {
            ThemeEditorView()
        }.environmentObject(tcManager)
    }
    
    private func onDelete(atOffsets: IndexSet) {
        tcManager.removeTheme(atOffsets: atOffsets)
    }
}
struct DestinationPageView: View {
    var theme: ThemeCollection.Theme
    var viewModel: EmojiMemoryGameViewModel
    
    init(theme: ThemeCollection.Theme) {
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
        ThemeSelectionView(tcManager: ThemeCollectionManager())
    }
}
