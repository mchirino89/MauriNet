
import XCTest
@testable import MauriNet

final class MauriNetURLTestCases: XCTestCase {
    var root: String!
    var path: String!
    var endpoint: APIEndpoint!

    override func setUp() {
        super.setUp()
        givenDummyURL()
    }

    override func tearDown() {
        super.tearDown()
        root = nil
        path = nil
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

    func testBuilderForURLWithQueryParams() throws {
        whenDefaultSetupIsReady()
        try thenVerifyQueryParamsAreProperlyBuilt()
    }
}

private extension MauriNetURLTestCases {
    func givenDummyURL() {
        root = "github.com"
        path = "testing"
    }

    func whenDefaultSetupIsReady() {
        endpoint = APIEndpoint(host: root)
    }

    func whenCustomConfigurationIsSet() {
        endpoint = APIEndpoint(host: root, httpMethod: .post, scheme: .unsafe, timeout: 30)
    }

    func thenVerifyAValidURLIsAssembled() {
        switch endpoint.buildRequest(for: path) {
        case .success(let assembledURL):
            XCTAssertEqual(assembledURL.url?.absoluteString, "https://github.com/testing")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func thenVerifyCustomConfigurationIsHandledProperly() {
        switch endpoint.buildRequest(for: path) {
        case .success(let assembledURL):
            XCTAssertEqual(assembledURL.url?.host, root)
            XCTAssertEqual(assembledURL.httpMethod, HTTPMethod.post.value)
            XCTAssertEqual(assembledURL.timeoutInterval, 30)
            XCTAssertEqual(assembledURL.url?.absoluteString, "http://github.com/testing")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func thenVerifyQueryParamsAreProperlyBuilt() throws {
        let path = "testing?param=1&param2=lalala"

        switch endpoint.buildRequest(for: path) {
        case .success(let assembledURL):
            let resultingURL = try XCTUnwrap(assembledURL.url?.absoluteString)
            let urlWithComponents = URLComponents(validURL: resultingURL)

            XCTAssertNotNil(assembledURL.url?.query)
            XCTAssertEqual(urlWithComponents.queryItems?.count, 2)
            XCTAssertEqual(urlWithComponents.queryItems?["param2"], "lalala")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }
}
