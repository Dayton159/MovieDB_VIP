//
//  FavoriteListMapper.swift
//  MovieDB-VIP
//
//  Created by Dayton on 21/01/22.
//

struct FavoriteListMapper: UniDirectMapper {
  typealias Response = [CDMovieFavorite]
  typealias Entity = [MovieEntity]
  typealias Domain = [MovieModel]
  
  func transformResponseToEntity(response: [CDMovieFavorite]) -> [MovieEntity] {
    return response.map {
      MovieEntity(
        idMovie: $0.idMovie,
        title: $0.title,
        overview: $0.overview,
        releaseDate: $0.releaseDate,
        backdropPath: $0.backdropPath,
        posterPath: $0.posterPath
      )
    }
  }
  
  func transformEntityToDomain(entity: [MovieEntity]) -> [MovieModel] {
    return entity.map {
      MovieModel(
        idMovie: Int($0.idMovie ?? 0),
        title: $0.title ?? "-",
        overview: $0.overview ?? "Not Available",
        releaseDate: DateFormatter.yearOnBack.stringFromDate($0.releaseDate) ?? "Unknown",
        backdropPath: $0.backdropPath ?? "",
        posterPath: $0.posterPath ?? ""
      )
    }
  }
}
