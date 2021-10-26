//
//  MovieListView.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/25/21.
//

import SwiftUI

struct MovieListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private var model = MovieViewModel()
    
    var body: some View {
            TabView {
                ListView(isFavorite: false)
                    .tabItem {
                        Label("All Movies", systemImage: "tv")
                    }

                ListView(isFavorite: true)
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
                
            }
            .onAppear(perform: model.fetchMovies) // Fetch API here from MovieViewModel
            .background(Color(UIColor.systemBackground))
            
    }
}

struct ListView: View {
    var isFavorite: Bool
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText)

                // Fetch movies from CoreData MovieInfo Entity and display in List
                FilteredList(searchString: searchText, isFavorite: isFavorite) { (movie: MovieInfo) in
                }
            }
            .navigationBarTitle("Movies")
            
        }.accentColor(Color(UIColor.secondaryLabel))
        
    }
}

// MARK: List View with track_name & is_favorite filter FetchRequest

struct FilteredList<T: MovieInfo, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // Content closure, we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { movie in
            
            NavigationLink(
                destination: MovieDetailView(movie: movie)) {
                MovieRowView(movie: movie)
            }
        }
    }

    // Initialize FilteredList view with track_name & is_favorite
    init(searchString: String = "", isFavorite: Bool, @ViewBuilder content: @escaping (T) -> Content) {
        
        if isFavorite && searchString.count > 0 {
            
            let predicate = NSPredicate(format: "track_name CONTAINS[c] %@ AND is_favorite == YES", searchString)
            
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MovieInfo.track_id, ascending: true)], predicate: predicate)
            
        } else if searchString.count > 0 {
            
            let predicate = NSPredicate(format: "track_name CONTAINS[c] %@", searchString)
            
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MovieInfo.track_id, ascending: true)], predicate: predicate)
            
        } else if isFavorite {
            
            let predicate = NSPredicate(format: "is_favorite == YES")
            
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MovieInfo.track_id, ascending: true)], predicate: predicate)
            
        } else {
            
            fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MovieInfo.track_id, ascending: true)])
        }
        
        self.content = content
    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListView()
////        MovieView(movie: TestData.movie)
//    }
//}
