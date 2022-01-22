//
//  DetailMapper.swift
//  MovieDB-VIP
//
//  Created by Dayton on 22/01/22.
//

struct DetailMapper: BidirectMapper {
  typealias Response = [ReviewResponse]
  typealias LocalResponse = [CDReview]
  typealias Entity = [ReviewEntity]
  typealias Domain = [ReviewModel]
  
  func transformResponseToEntity(response: [CDReview]) -> [ReviewEntity] {
    return response.map {
      ReviewEntity(
        author: $0.author,
        avatar: $0.detail?.avatar,
        rating: $0.detail?.rating,
        date: $0.date
      )
    }
  }
  
  func transformResponseToEntity(response: [ReviewResponse]) -> [ReviewEntity] {
    return response.map {
      ReviewEntity(
        author: $0.author,
        avatar: $0.detail?.avatar,
        rating: $0.detail?.rating,
        date: DateFormatter.JSONReview.dateFromString($0.date ?? "")
      )
    }
  }
  
  func transformDomainToEntity(domain: [ReviewModel]) -> [ReviewEntity] {
    return domain.map {
      ReviewEntity(
        author: $0.author,
        avatar: $0.avatar.url,
        rating: Double($0.rating),
        date: DateFormatter.yearOnBack.dateFromString($0.date)
      )
    }
  }

  func transformEntityToDomain(entity: [ReviewEntity]) -> [ReviewModel] {
    return entity.map {
      ReviewModel(
        author: $0.author ?? "Unknown",
        avatar: $0.avatar ?? "",
        rating: $0.rating?.toString() ?? "Not Available",
        date: DateFormatter.yearOnBack.stringFromDate($0.date) ?? "Unknown"
      )
    }
  }
  
  func transformDetailDomainToEntity(detail: DetailModel) -> DetailEntity {
    return DetailEntity(
      movie: MovieEntity(
        idMovie: Int64(detail.movieModel.idMovie),
        title: detail.movieModel.title,
        overview: detail.movieModel.overview,
        releaseDate: DateFormatter.yearOnBack.dateFromString(detail.movieModel.releaseDate),
        backdropPath: detail.movieModel.asyncImage.url,
        posterPath: detail.movieModel.asyncPoster.url),
      review: detail.review.map {
        CDReview(
          author: $0.author,
          detail: CDAuthor(avatar: $0.avatar.url,
                           rating: Double($0.rating)),
          date: DateFormatter.yearOnBack.dateFromString($0.date))
      })
  }
}
