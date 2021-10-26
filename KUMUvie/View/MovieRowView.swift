//
//  MovieRowView.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/26/21.
//

import SwiftUI
import CoreData

struct MovieRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var movie: MovieInfo
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 16) {
            
            AsyncImage(url: URL(string: movie.artwork ?? "")!, placeholder: {Text("Loading...")})
                .aspectRatio(2/3, contentMode: .fit)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Button(action: {
                        addToFavorite() // Mark Movie as Favorite

                    }) {
                        
                        if movie.is_favorite {
                            
                            Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .foregroundColor(.red)
                        } else {
                            
                            Image(systemName: "heart")
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            
                        }
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                }
                
                Text(movie.track_name ?? "")
                    .font(.headline)
                
                Text(movie.genre ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(String(format: "Price: %.2f", movie.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        }.frame(height: 160)
    }
    
    // Update Movie's is_favorite value
    private func addToFavorite() {
        
        let newMovie = MovieInfo(context: viewContext)
        newMovie.track_id = movie.track_id
        newMovie.track_name = movie.track_name
        newMovie.genre = movie.genre
        newMovie.price = movie.price
        newMovie.long_description = movie.long_description
        newMovie.artwork = movie.artwork
        newMovie.is_favorite = !movie.is_favorite

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct MovieRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRowView()
//    }
//}
