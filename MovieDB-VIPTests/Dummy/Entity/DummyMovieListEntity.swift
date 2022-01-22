//
//  DummyMovieListEntity.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

@testable import MovieDB_VIP

extension MovieEntity {
  static var dummy: [MovieEntity] {
    .init(
      [
        .init(
          idMovie: 566525,
          title: "Shang-Chi and the Legend of the Ten Rings",
          overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-09-01"),
          backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
          posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
        ),
        .init(
          idMovie: 580489,
          title: "Venom: Let There Be Carnage",
          overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-09-30"),
          backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
          posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
        ),
        .init(
          idMovie: 524434,
          title: "Eternals",
          overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-11-03"),
          backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
          posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
        )
      ]
    )
  }
  
  static var dummyLocal: [MovieEntity] {
    .init(
      [
        .init(
          idMovie: 524434,
          title: "Eternals",
          overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-11-03"),
          backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
          posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
        ),
        .init(
          idMovie: 580489,
          title: "Venom: Let There Be Carnage",
          overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-09-30"),
          backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
          posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
        ),
        .init(
          idMovie: 566525,
          title: "Shang-Chi and the Legend of the Ten Rings",
          overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
          releaseDate: DateFormatter.JSONResponse.dateFromString("2021-09-01"),
          backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
          posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
        )
      ]
    )
  }
}
