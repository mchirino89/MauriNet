import Combine
import XCTest
@testable import MauriNet

final class MauriNetTests: XCTestCase {
    func testChainedRequests() {
        // Given
        let mockChain1 = buildChainableRequests()
        let mockChain2 = buildChainableRequests()

        // When
        mockChain1.compactMap { $0.f
        }
        mockChain2.flatMap {
            mockChain1.
        }
    }
}

private extension MauriNetTests {
    func buildChainableRequests() -> AnyPublisher<DummyDecodable, Error> {
        let dummyRequest = URLRequest(url: URL(string: "lala")!)
        let mockChain = SessionMother.assembleChainableSession()

        return mockChain.run(dummyRequest)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
