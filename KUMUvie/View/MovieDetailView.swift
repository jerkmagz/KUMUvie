//
//  MovieDetailView.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/25/21.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var movie: MovieInfo
    
    var body: some View {
        ScrollView{
            
            VStack(alignment: .leading, spacing: 12) {
                
                MovieRowView(movie: movie)
                
                Divider()

                Text("About \(movie.track_name ?? "")")
                    .font(.headline)
                    .frame(alignment: .leading)
                    .aspectRatio(contentMode: .fit)
                Text(movie.long_description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
            .padding()
        }
        .navigationTitle(movie.track_name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(movie: <#MovieInfo#>)
//    }
//}
