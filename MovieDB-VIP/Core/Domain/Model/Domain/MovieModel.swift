//
//  MovieModel.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

struct MovieModel: Equatable {
  let idMovie: Int
  let title: String
  let overview: String
  let releaseDate: String
  let asyncImage: ImageDownloader
  let asyncPoster: ImageDownloader
  
  init(
    idMovie: Int,
    title: String,
    overview: String,
    releaseDate: String,
    backdropPath: String,
    posterPath: String
  ) {
    self.idMovie = idMovie
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
    self.asyncImage = ImageDownloader(url: backdropPath)
    self.asyncPoster = ImageDownloader(url:posterPath)
  }
}
