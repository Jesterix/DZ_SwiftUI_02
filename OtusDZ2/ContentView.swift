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
            Picker(selection: $selection, label: Text("News") ) {
                ForEach(0..<ingredientViewModel.items.count) { index in
                    Text(self.ingredientViewModel.items[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Text("Value: \(ingredientViewModel.items[selection])")
            Spacer()
            RecipeListView(ingredient: ingredientViewModel.items[selection])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
