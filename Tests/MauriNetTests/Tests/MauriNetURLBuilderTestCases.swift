
import XCTest
@testable import MauriNet

final class MauriNetURLBuilderTestCases: XCTestCase {
    var root: String!
    var path: String!
    var endpoint: APIEndpoint!
    var endpointBuilder: EndpointBuilder!
    var resultingURL: URLRequest!
    var query: [String: String]!

    override func setUp() {
        super.setUp()
        givenDummyURL()
    }

    override func tearDown() {
        super.tearDown()
        root = nil
        path = nil
        endpoint = nil
        endpointBuilder = nil
        resultingURL = nil
        query = nil
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

    func testConvenienceBuilderAPI() {
        whenCustomConfigurationIsSet()
        whenURLIsAssembledUsingConvenienceBuilder()
        thenVerifyProperBuiltFor(assembledURL: resultingURL, against: endpoint)
    }

    func testConvenienceBuilderAPIWithParameters() throws {
        whenDefaultSetupIsReady()
        whenURLIWithParamssAssembledUsingConvenienceBuilder()
        try thenVerifyProperQueryBuiltFor(assembledURL: resultingURL, query: query)
    }

    func testDefaultCaseForConvenienceAPIBuilder() {
    }
}

private extension MauriNetURLBuilderTestCases {
    func givenDummyURL() {
        root = "github.com"
        path = "testing"
        query = ["param": "1", "param2": "lalala"]
    }

    func whenDefaultSetupIsReady() {
        endpoint = APIEndpoint(host: root)
    }

    func whenCustomConfigurationIsSet() {
        endpoint = APIEndpoint(host: root, httpMethod: .post, scheme: .unsafe, timeout: 30)
    }

    func whenURLIsAssembledUsingConvenienceBuilder() {
        endpointBuilder = EndpointBuilder(endpointSetup: endpoint)
        resultingURL = endpointBuilder.assembleRequest(path: path)
    }

    func whenURLIWithParamssAssembledUsingConvenienceBuilder() {
        endpointBuilder = EndpointBuilder(endpointSetup: endpoint)
        resultingURL = endpointBuilder.assembleRequest(path: path, queryParameters: query)
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
            thenVerifyProperBuiltFor(assembledURL: assembledURL, against: endpoint)
            XCTAssertEqual(assembledURL.url?.absoluteString, "http://github.com/testing")
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func thenVerifyQueryParamsAreProperlyBuilt() throws {
        let path = "testing"

        switch endpoint.buildRequest(for: path, with: query) {
        case .success(let assembledURL):
            try thenVerifyProperQueryBuiltFor(assembledURL: assembledURL, query: query)
        case .failure(let error):
            XCTFail("Failed due to \(error.localizedDescription)")
        }
    }

    func thenVerifyProperBuiltFor(assembledURL: URLRequest, against config: APIEndpoint) {
        XCTAssertEqual(assembledURL.url?.host, config.host)
        XCTAssertEqual(assembledURL.httpMethod, config.httpMethod.value)
        XCTAssertEqual(assembledURL.timeoutInterval, config.timeout)
    }

    func thenVerifyProperQueryBuiltFor(assembledURL: URLRequest, query: [String: String]) throws {
        let resultingURL = try XCTUnwrap(assembledURL.url?.absoluteString)
        let urlWithComponents = URLComponents(validURL: resultingURL)

        XCTAssertNotNil(assembledURL.url?.query)
        XCTAssertEqual(urlWithComponents.queryItems?.count, query.count)
        try urlWithComponents.queryItems?.forEach { item in
            let value = try XCTUnwrap(item.value)
            XCTAssertEqual(urlWithComponents.queryItems?[item.name], query[item.name])
            XCTAssertEqual(urlWithComponents.queryItems?[value], query[value])
        }
    }
}
