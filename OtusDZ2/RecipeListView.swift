//
//  Recipes.swift
//  ListWithPaginng
//
//  Created by exey on 12.03.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import SwiftUI
import Combine

final class RecipesViewModel: ObservableObject {
    private var ingredientViewModel = IngredientListModel()
    @Published private(set) var items: [Recipe] = [Recipe]()
    @Published private(set) var page: Int = 0
    @Published private(set) var isPageLoading: Bool = false
    @Published var segmentIndex: Int = 0
    private var currentIngredient: String = ""

    private var disposables = Set<AnyCancellable>()

    init() {
        $segmentIndex
            .sink { index in
                self.items.removeAll()
                self.currentIngredient = self.ingredientViewModel.items[index]
                self.loadPage()
            }
            .store(in: &disposables)
    }

    func loadPage() {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true
        page += 1
        RecipeAPI.getRecipe(
            i: "tomato,\(currentIngredient)",
            q: "salad", p: page)
        { response, error in
            if let results = response?.results {
                self.items.append(contentsOf: results)
            }
            self.isPageLoading = false
        }
    }
}

extension Recipe: Identifiable {
    public var id: String {
        self.title ?? UUID().uuidString
    }
}

struct RecipeRow: View {
    @EnvironmentObject var viewModel: RecipesViewModel
    
    let item: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title ?? "")
                .font(.headline)
            Text(item.ingredients ?? "")
                .font(.callout)
                .foregroundColor(.gray)
            
            if self.viewModel.isPageLoading && self.viewModel.items.isLast(item) {
                Divider()
                Text("Loading...")
            }
        }
    }
}

struct RecipeListView: View {
    @EnvironmentObject var viewModel: RecipesViewModel

    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    RecipeRow(item: item)
                        .onAppear() {
                            if self.viewModel.items.isLast(item) {
                                self.viewModel.loadPage()
                            }
                    }
                    NavigationLink(destination: RecipeView(recipe: item))
                    {
                        Text("Learn more...")
                    }
                }
            }
            .navigationBarTitle("Recipes")
            .onAppear() {
                self.viewModel.loadPage()
            }
        }
    }
}
