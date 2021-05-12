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
    @Environment(\.presentationMode) var presentation
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(tcManager.themes) { theme in
                    NavigationLink(destination: DestinationPageView(theme: theme)) {
                        HStack {
                            displayCircularEditButton(theme: theme)
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
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        selectedTheme = nil
                        self.showingSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    })
                }
            }.environment(\.editMode, $editMode)
            .navigationTitle("Themes")
            
            DestinationPageView(theme: DefaultThemes.theme1)
            // Text("⬅️Select your theme from sidebar")
        }
        .sheet(isPresented: $showingSheet) {
            if selectedTheme != nil {
                ThemeEditorView(theme: selectedTheme!)
            } else {
                ThemeEditorView()
            }
        }.environmentObject(tcManager)
    }
    
    @State private var selectedTheme: ThemeCollection.Theme? = nil
    
    private func onDelete(atOffsets: IndexSet) {
        tcManager.removeTheme(atOffsets: atOffsets)
    }
    
    @ViewBuilder
    private func displayCircularEditButton(theme: ThemeCollection.Theme) -> some View {
        withAnimation(.easeIn) {
            ZStack{
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(.blue)
                    .imageScale(.large)
                    .opacity(editMode.isEditing ? 1:0)
                    .onTapGesture {
                        selectedTheme = theme
                        showingSheet = true
                    }
                Image(systemName: "chevron.right.circle.fill")
                    .opacity(editMode.isEditing ? 0:1)
                    .foregroundColor(Color(theme.accentColor))
            }
        }
    }
}

//struct CircularEditButtonView: View {
//    var theme: ThemeCollection.Theme
//    var isEditing: Bool
//    var body: some View {
//        withAnimation(.easeInOut) {
//            ZStack{
//                Image(systemName: "pencil.circle.fill")
//                    .foregroundColor(Color(theme.accentColor))
//                    .opacity(isEditing ? 1:0)
//                    .onTapGesture {
//                        selectedTheme = theme
//                        showingSheet = true
//                    }
//                Image(systemName: "chevron.right.circle.fill")
//                    .opacity(isEditing ? 0:1)
//                    .foregroundColor(Color(theme.accentColor))
//            }
//        }
//
//    }
//}

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
