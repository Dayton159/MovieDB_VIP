//
//  DummyCDModel.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 21/01/22.
//

import CoreData
@testable import MovieDB_VIP

extension CDMovieFavorite {
  static func dummy(context: NSManagedObjectContext) -> [CDMovieFavorite] {
    let fav1 = CDMovieFavorite(context: context)
    fav1.idMovie = 524434
    fav1.title = "Eternals"
    fav1.overview = "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants."
    fav1.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-11-03")
    fav1.backdropPath = "/fzKWwcaam9QSTaMSJlORuSojxio.jpg"
    fav1.posterPath = "/6AdXwFTRTAzggD2QUTt5B7JFGKL.jpg"
    fav1.reviews = CDReview.dummy

    let fav2 = CDMovieFavorite(context: context)
    fav2.idMovie = 580489
    fav2.title = "Venom: Let There Be Carnage"
    fav2.overview = "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady."
    fav2.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-09-30")
    fav2.backdropPath = "/efuPybo8V8KTYGslQphO74LRvm0.jpg"
    fav2.posterPath = "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg"
    fav2.reviews = CDReview.dummy

    let fav3 = CDMovieFavorite(context: context)
    fav3.idMovie = 566525
    fav3.title = "Shang-Chi and the Legend of the Ten Rings"
    fav3.overview = "Shang-Chi must confront the past he thought he left behind when he is drawn into the web of the mysterious Ten Rings organization."
    fav3.releaseDate = DateFormatter.JSONResponse.dateFromString("2021-09-01")
    fav3.backdropPath = "/cinER0ESG0eJ49kXlExM0MEWGxW.jpg"
    fav3.posterPath = "/xeItgLK9qcafxbd8kYgv7XnMEog.jpg"
    fav3.reviews = CDReview.dummy

    return [fav1, fav2, fav3]
  }
}

