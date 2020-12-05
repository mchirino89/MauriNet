
import XCTest
@testable import MauriNet

final class MauriNetURLTestCases: XCTestCase {
    var root: String!
    var endpoint: APIEndpoint!

    override func setUp() {
        super.setUp()
        givenDummyURL()
    }

    override func tearDown() {
        super.tearDown()
        root = nil
        endpoint = nil
    }

    func testURLAssemble() {
        whenDefaultSetupIsReady()
        thenVerifyAValidURLIsAssembled()
    }

    func testURLProperConfiguration() {
        whenCustomConfigurationIsSet()
        thenVerifyCustomConfigurationIsHandledProperly()
    }
}

private extension MauriNetURLTestCases {
    func givenDummyURL() {
        root = "github.com"
    }

    func whenDefaultSetupIsReady() {
        endpoint = APIEndpoint(host: root)
    }

    func whenCustomConfigurationIsSet() {
        endpoint = APIEndpoint(host: root, httpMethod: .post, scheme: .unsafe, timeout: 30)
    }

    func thenVerifyAValidURLIsAssembled() {
        switch endpoint.buildRequest(for: "testing") {
        case .success(let assembledURL):
            XCTAssertEqual(assembledURL.url?.absoluteString, "https://github.com/testing")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func thenVerifyCustomConfigurationIsHandledProperly() {
        let path = "testing"
        switch endpoint.buildRequest(for: path) {
        case .success(let assembledURL):
            XCTAssertEqual(assembledURL.httpMethod, HTTPMethod.post.value)
            XCTAssertEqual(assembledURL.timeoutInterval, 30)
            XCTAssertEqual(assembledURL.url?.absoluteString, "http://github.com/testing")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }
}
