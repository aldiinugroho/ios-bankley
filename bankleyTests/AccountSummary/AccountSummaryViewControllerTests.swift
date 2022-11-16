//
//  AccountSummaryViewControllerTests.swift
//  bankleyTests
//
//  Created by aldinugroho on 16/11/22.
//

import Foundation
import XCTest

@testable import bankley

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
}
