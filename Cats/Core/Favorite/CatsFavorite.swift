//
//  CatsFavorite.swift
//  Cats
//
//  Created by Mark Khmelnitskii on 10.04.2022.
//

import SwiftUI

struct CatsFavorite: View {
    @ObservedObject var viewModel = CatsFavoriteViewModel()
    var body: some View {
        NavigationView{
            Group {
                switch viewModel.state {
                case .empty:
                    VStack {
                        Text("Empty")
                        Text("add first cat to saved")
                    }
                case .loaded(let catsDB):
                    GeometryReader { geo in
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)) {
                                ForEach(catsDB, id: \.unicID) { cat in
                                    NavigationLink(destination: CatsFavoriteDetail(cat: cat)) {
                                        if let imageData = cat.image,
                                           let uiimage = UIImage(data: imageData),
                                           let image = Image(uiImage: uiimage) {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: geo.size.width/3, height: geo.size.width/3, alignment: .center)
                                                .clipped()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .toolbar {
                        Button {
                            viewModel.deleteAll()
                        } label: {
                            Text("Empty saved")
                        }
                    }
                case .error(let error):
                    Text(error)
                case .loading:
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.fetchCats()
            }
            .navigationTitle("Saved cat's")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CatsFavorite_Previews: PreviewProvider {
    static var previews: some View {
        CatsFavorite()
    }
}
