//
//  ContentView.swift
//  OtusDZ2
//
//  Created by Георгий Хайденко on 16.03.2020.
//  Copyright © 2020 George Khaydenko. All rights reserved.
//

import SwiftUI

final class IngredientListModel: ObservableObject {
    @Published private(set) var items: [String] = ["avocado",
                                                   "cucumber",
                                                   "onions"]
}

struct ContentView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @EnvironmentObject var ingredientViewModel: IngredientListModel

    @State private var selection = 0

    var body: some View {
        VStack{
            Text("Salad with tomato and")
            RecipeListPicker(title: "Recipes", ingredientViewModel: _ingredientViewModel, segmentIndex: $selection)

            Spacer()

            NavControllerView(transition: .custom(.scale)) {
                RecipeListView(ingredient: self.ingredientViewModel.items[self.selection])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RecipeListPicker: View {
    let title: String

    @EnvironmentObject var ingredientViewModel: IngredientListModel
    @Binding var segmentIndex: Int

    var body: some View {
        Picker(title, selection: $segmentIndex) {
            ForEach(0..<ingredientViewModel.items.count) { index in
                Text(self.ingredientViewModel.items[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
