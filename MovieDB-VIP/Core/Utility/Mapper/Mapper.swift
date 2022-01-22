//
//  Mapper.swift
//  MovieDB-VIP
//
//  Created by Dayton on 19/01/22.
//

protocol UniDirectMapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}

protocol BidirectMapper: UniDirectMapper {
  associatedtype LocalResponse
  
  func transformResponseToEntity(response: LocalResponse) -> Entity
  func transformDomainToEntity(domain: Domain) -> Entity
}

