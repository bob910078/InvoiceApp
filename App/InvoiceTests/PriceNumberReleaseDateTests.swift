//
//  PriceNumberReleaseDateTests.swift
//  InvoiceTests
//
//  Created by Bob Chang on 2021/1/1.
//

import XCTest

class PriceNumberReleaseDateTests: XCTestCase {
    
    func testDateInit() {
        let date1 = Date(dateString: "2020-01-31")
        XCTAssertNotNil(date1)
        let date2 = Date(dateString: "2020-01-32")
        XCTAssertNil(date2)
    }
    
    // MARK: - Jan
    func testJan01() {
        let date = Date(dateString: "2020-01-01")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2019-11-25")!)
    }
    
    func testJan11() {
        let date = Date(dateString: "2020-01-11")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2019-11-25")!)
    }
    
    func testJan21() {
        let date = Date(dateString: "2020-01-21")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2019-11-25")!)
    }
    
    func testJan31() {
        let date = Date(dateString: "2020-01-31")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    // MARK: - Feb
    func testFeb01() {
        let date = Date(dateString: "2020-02-01")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testFeb11() {
        let date = Date(dateString: "2020-02-11")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testFeb21() {
        let date = Date(dateString: "2020-02-21")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testFeb28() {
        let date = Date(dateString: "2020-02-28")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    // MARK: - Mar
    func testMar01() {
        let date = Date(dateString: "2020-03-01")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testMar11() {
        let date = Date(dateString: "2020-03-11")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testMar21() {
        let date = Date(dateString: "2020-03-21")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-01-25")!)
    }
    
    func testMar31() {
        let date = Date(dateString: "2020-03-31")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    // MARK: - Apr
    func testApr01() {
        let date = Date(dateString: "2020-04-01")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testApr11() {
        let date = Date(dateString: "2020-04-11")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testApr21() {
        let date = Date(dateString: "2020-04-21")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testApr30() {
        let date = Date(dateString: "2020-04-30")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    // MARK: - May
    func testMay01() {
        let date = Date(dateString: "2020-05-01")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testMay11() {
        let date = Date(dateString: "2020-05-11")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testMay21() {
        let date = Date(dateString: "2020-05-21")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-03-25")!)
    }
    
    func testMay31() {
        let date = Date(dateString: "2020-05-31")!
        let sut = TermHelper()
        let output = sut.getPriceNumberReleaseDate(today: date)
        XCTAssertEqual(output, Date(dateString: "2020-05-25")!)
    }
    
    
}
