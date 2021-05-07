//
//  ThemeSelectionView.swift
//  memory-card-matching-game
//
//  Created by Archie Liu on 2021-05-04.
//

import SwiftUI

struct ThemeSelectionView: View {
    @State private var showingPopover = false
    @ObservedObject var tcManager: ThemeCollectionManager
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        print("start: \(tcManager.themes)")
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
            .navigationTitle("Themes")
            .navigationBarItems(trailing: HStack {
                //Button(action: {self.showingPopover = true}, label: {Image(systemName: "pencil").resizable().frame(width: 20, height: 20)})
                //EditButton().padding(5)
                Button(action: {self.showingPopover = true}, label: {Image(systemName: "plus")}).padding(5)//.resizable().frame(width: 20, height: 20)
            }
            .sheet(isPresented: $showingPopover) {
                    ThemeEditorView { name, accentColor, emojiSet  in
                        tcManager.addTheme(name: name, accentColor: UIColor(accentColor), emojiSet: emojiSet)
                        
                        print(tcManager.themes)
                    }
            }
            ).environment(\.editMode, $editMode)
        }
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
