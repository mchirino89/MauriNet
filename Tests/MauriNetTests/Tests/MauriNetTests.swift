import Combine
import XCTest
@testable import MauriNet

final class MauriNetTests: XCTestCase {
    func testChainedRequests() {
        // Given
        let mockChain1: AnyPublisher<[DummyDecodable], Error> = RequestsMother.buildRequests()
        let mockChain2: AnyPublisher<DummyDecodable, Error> = RequestsMother.buildRequests()

        // When
        let firstMatch = mockChain1.compactMap { $0.first }
        let joined = firstMatch.flatMap {
            mockChain2.append($0)
        }
        // TODO: find a way how to fix the chaining.
//        let token = joined.sink(receiveCompletion: { _ in },
//                                receiveValue: { print($0) })

        // Then
    }
}
