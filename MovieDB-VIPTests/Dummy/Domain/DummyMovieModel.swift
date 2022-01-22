//
//  DummyMovieModel.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

@testable import MovieDB_VIP

extension MovieModel {
  static var dummy: [MovieModel] {
    .init(
      [
        .init(
          idMovie: 566525,
          title: "Shang-Chi and the Legend of the Ten Rings",
          overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
          releaseDate: "01 Sep 2021",
          backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
          posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
        ),
        .init(
          idMovie: 580489,
          title: "Venom: Let There Be Carnage",
          overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          releaseDate: "30 Sep 2021",
          backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
          posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
        ),
        .init(
          idMovie: 524434,
          title: "Eternals",
          overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
          releaseDate: "03 Nov 2021",
          backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
          posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
        )
      ]
    )
  }
  
  static var dummyLocal: [MovieModel] {
    .init(
      [
        .init(
          idMovie: 524434,
          title: "Eternals",
          overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
          releaseDate: "03 Nov 2021",
          backdropPath: "/fzKWwcaam9QSTaMSJlORuSojxio.jpg",
          posterPath: "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
        ),
        .init(
          idMovie: 580489,
          title: "Venom: Let There Be Carnage",
          overview: "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          releaseDate: "30 Sep 2021",
          backdropPath: "/efuPybo8V8KTYGslQphO74LRvm0.jpg",
          posterPath: "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
        ),
        .init(
          idMovie: 566525,
          title: "Shang-Chi and the Legend of the Ten Rings",
          overview: "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization.",
          releaseDate: "01 Sep 2021",
          backdropPath: "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg",
          posterPath: "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
        )
      ]
    )
  }
  
  static var dummyFirst: MovieModel {
    return dummy[0]
  }
  
  static var dummyLocalFirst: MovieModel {
    return dummyLocal[0]
  }
}
