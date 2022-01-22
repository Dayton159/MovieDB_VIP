//
//  DummyDetailModel.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 22/01/22.
//


@testable import MovieDB_VIP

extension DetailModel {
  static var dummy: DetailModel {
    .init(movieModel: MovieModel.dummyFirst, review: ReviewModel.dummy)
  }
  
  static var dummyLocal: DetailModel {
    .init(movieModel: MovieModel.dummyLocalFirst, review: ReviewModel.dummyLocal)
  }
}
