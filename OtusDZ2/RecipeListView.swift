//
//  Recipes.swift
//  ListWithPaginng
//
//  Created by exey on 12.03.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import SwiftUI

final class RecipesViewModel: ObservableObject {
    @Published private(set) var items: [Recipe] = [Recipe]()
    @Published private(set) var page: Int = 0
    @Published private(set) var isPageLoading: Bool = false
    
    func loadPage()  {
        guard isPageLoading == false else {
            return
        }
        isPageLoading = true
        page += 1
        RecipeAPI.getRecipe(i: "avocado,tomato", q: "salad", p: page) { response, error in
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
                }
            }
            .navigationBarTitle("Recipes")
            .onAppear() {
                self.viewModel.loadPage()
            }
        }
    }
}
