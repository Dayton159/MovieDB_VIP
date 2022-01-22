//
//  DetailFavDataSource.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

import Foundation
import Combine
import CoreData

protocol DetailFavDataSourceProtocol: AnyObject {
  func saveMovie(movie: DetailEntity) -> AnyPublisher<Void, APIServiceError>
  func getMovieReviews() -> AnyPublisher<[CDReview], APIServiceError>
  func deleteFavoriteMovie() -> AnyPublisher<Void, APIServiceError>
  func isMovieFavorited() -> AnyPublisher<Bool, APIServiceError>
}

final class DetailFavDataSource {
  private let _context: NSManagedObjectContext
  private let _save: SaveMovieRequest
  private let _delete: DeleteMovieRequest
  private let _isFav: IsFavoritedRequest
  private let _review: ReviewLocalRequest
  
  init(save: SaveMovieRequest, delete: DeleteMovieRequest, isFav: IsFavoritedRequest, review: ReviewLocalRequest, context: NSManagedObjectContext) {
    self._save = save
    self._delete = delete
    self._isFav = isFav
    self._review = review
    self._context = context
  }
}

extension DetailFavDataSource: DetailFavDataSourceProtocol {
  func saveMovie(movie: DetailEntity) -> AnyPublisher<Void, APIServiceError> {
    return Future<Void, APIServiceError> { completion in
            self._context.performAndWait {
              if let favorite = self._save.makeEntityDescription(context: self._context) {
                let newFavorite = NSManagedObject(entity: favorite, insertInto: self._context)
                newFavorite.setValue(movie.movie.idMovie, forKey: "idMovie")
                newFavorite.setValue(movie.movie.title, forKey: "title")
                newFavorite.setValue(movie.movie.overview, forKey: "overview")
                newFavorite.setValue(movie.movie.releaseDate, forKey: "releaseDate")
                newFavorite.setValue(movie.movie.backdropPath, forKey: "backdropPath")
                newFavorite.setValue(movie.movie.posterPath, forKey: "posterPath")
                newFavorite.setValue(movie.review, forKey: "reviews")
              }
              if self._context.hasChanges {
                do {
                  try self._context.save()
                  completion(.success(()))
                } catch let error {
                  completion(.failure(APIServiceError.custom(error)))
                }
              }
            }
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func getMovieReviews() -> AnyPublisher<[CDReview], APIServiceError> {
    return Future<[CDReview], APIServiceError> { completion in
      self._context.perform {
        let fetchRequest = self._review.makeFetchRequest()
        do {
          guard let movie = try self._context.fetch(fetchRequest).first as? CDMovieFavorite,
                let result = movie.reviews else { return }
          completion(.success(result))
        } catch let error {
          completion(.failure(APIServiceError.custom(error)))
        }
      }
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func deleteFavoriteMovie() -> AnyPublisher<Void, APIServiceError> {
    return Future<Void, APIServiceError> { completion in
      self._context.performAndWait {
        let fetchRequest = self._delete.makeFetchRequest()
        do {
          guard let result = try self._context.fetch(fetchRequest).first as? CDMovieFavorite else { return }
          self._context.delete(result)

          if self._context.hasChanges {
            try self._context.save()
            completion(.success(()))
          }
        } catch let error {
          completion(.failure(APIServiceError.custom(error)))
        }
      }
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
  
  func isMovieFavorited() -> AnyPublisher<Bool, APIServiceError> {
    return Future<Bool, APIServiceError> { completion in
      self._context.perform {
        let fetchRequest = self._isFav.makeFetchRequest()
        do {
          if try self._context.fetch(fetchRequest).first != nil {
            completion(.success(true))
          } else {
            completion(.success(false))
          }
        } catch {
          completion(.failure(APIServiceError.custom(error)))
        }
      }
    }
    .subscribe(on: DispatchQueue.global(qos: .background))
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
  }
}
