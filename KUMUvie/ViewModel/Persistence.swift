//
//  Persistence.swift
//  KUMUvie
//
//  Created by Jerk Nino Magdadaro on 10/23/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    // Insert response in CoreDate MovieInfo Entity
    func insertMovie(movies: [MovieModel]) {
        let viewContext = container.viewContext
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        for movie in movies {
            
            // Check if track already exist in our entity to retain is_favorite
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieInfo")
            fetchRequest.predicate = NSPredicate(format: "track_id = %d", movie.trackId)
            
            var results: [NSManagedObject] = []

            do {
                results = try viewContext.fetch(fetchRequest)
                
                    let result = results.first as? MovieInfo
                    
                    let newMovie = MovieInfo(context: viewContext)
                    newMovie.track_id = Int32(movie.trackId)
                    newMovie.track_name = movie.trackName
                    newMovie.genre = movie.primaryGenreName
                    newMovie.price = movie.trackPrice
                    newMovie.long_description = movie.longDescription
                    newMovie.artwork = movie.artworkUrl100
                    newMovie.is_favorite = result?.is_favorite ?? false
                
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "KUMUvie")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
