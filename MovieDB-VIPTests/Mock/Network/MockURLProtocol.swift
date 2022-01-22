//
//  MockURLProtocol.swift
//  MovieDB-VIPTests
//
//  Created by Dayton on 19/01/22.
//

import Foundation

final class MockURLProtocol: URLProtocol {

  private(set) var activeTask: URLSessionTask?

  enum ResponseType {
    case error(Error)
    case success(HTTPURLResponse)
  }
  static var responseType: ResponseType!
  static var data: Data?

  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
    return false
  }

  private lazy var session: URLSession = {
    let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
    return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
  }()

  override func startLoading() {
    activeTask = session.dataTask(with: request)
    activeTask?.cancel()
  }

  override func stopLoading() {
    activeTask?.cancel()
  }
}

extension MockURLProtocol: URLSessionDataDelegate {

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    client?.urlProtocol(self, didLoad: MockURLProtocol.data ?? data)
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    switch MockURLProtocol.responseType {
    case .error(let error)?:
      client?.urlProtocol(self, didFailWithError: error)
    case .success(let response)?:
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
//      if let data = MockURLProtocol.data {
        client?.urlProtocol(self, didLoad: MockURLProtocol.data ?? Data())
//      }
    default:
      break
    }

    client?.urlProtocolDidFinishLoading(self)
  }
}

enum MockError: Error {
  case none
}

extension MockURLProtocol {

  static func responseWithFailure() {
    MockURLProtocol.responseType = MockURLProtocol.ResponseType.error(MockError.none)
  }

  static func responseWithStatusCode(code: Int, data: Data?) {
    MockURLProtocol.data = data
    MockURLProtocol.responseType = MockURLProtocol.ResponseType.success(HTTPURLResponse(url: URL(string: "http://any.com")!, statusCode: code, httpVersion: nil, headerFields: nil)!)
  }
}
