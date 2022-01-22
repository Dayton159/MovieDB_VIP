//
//  MovieListMapper.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct MovieListMapper: UniDirectMapper {
  typealias Response = [MovieResponse]
  typealias Entity = [MovieEntity]
  typealias Domain = [MovieModel]

  func transformResponseToEntity(response: [MovieResponse]) -> [MovieEntity] {
    return response.map {
      MovieEntity(
       idMovie: $0.idMovie.flatMap { Int64($0) },
       title: $0.title,
       overview: $0.overview,
       releaseDate: DateFormatter.JSONResponse.dateFromString($0.releaseDate ?? ""),
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
