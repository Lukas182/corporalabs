//
//  corporaTests.swift
//  corporaTests
//
//  Created by David Ortego Lucas on 4/11/22.
//

import XCTest
@testable import corpora

class corporaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExpectedNotNil() throws {
        
        var expected : [Episode]?
        
        let fakeService = FakeResponseService()
        
        NetWorkManager.init(wbs: fakeService).apiCall_GetEpisodes(urlEpisodes: ["http://www.test.com"]) { result in
            switch result
            {
            case .success(let episodes):
                expected = episodes
                break
            case .failure(let error):
                print("error")
                print(error)
                break
            }
        }
        
        XCTAssertNil(expected)
        
    }
    
    func testExpectedRowCount() throws {
        
        var expected : CharacterResponse?
        
        let expectedRowCount = 3
        
        let fakeService = FakeResponseService()
        
        NetWorkManager.init(wbs: fakeService).apiCall_GetCharacters(next: nil, filter: nil, query: nil) { result in
            switch result
            {
            case .success(let response):
                expected = response
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(expected?.results.count, expectedRowCount)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class FakeResponseService : NetWorkServiceProtocol {
    func getCharacters(next: String?, filter: String?, query: String?, completion: @escaping (Swift.Result<CharacterResponse, Error>) -> Void) {
        guard let filepath = Bundle.main.path(forResource: "MockFile", ofType: "json") else {
                    return
                }
        
        let data = FileManager.default.contents(atPath: filepath)
        
        let decoder = JSONDecoder()
        let result = try! decoder.decode(CharacterResponse.self, from: data!)
        
        completion(.success(result))
    }
    
    func getEpisode(url: String, completion: @escaping (Swift.Result<Episode, Error>) -> Void) {
        completion(.failure(CustomError.failedRequest))
    }
    
}
