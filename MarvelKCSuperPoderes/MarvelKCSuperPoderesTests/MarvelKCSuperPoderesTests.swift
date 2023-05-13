//
//  MarvelKCSuperPoderesTests.swift
//  MarvelKCSuperPoderesTests
//
//  Created by Markel Juaristi on 25/3/23.
//



import XCTest
import Combine
@testable import MarvelKCSuperPoderes

final class MarvelKCSuperPoderesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testHeroModel() {
        let thumbnail = HeroeThumbnail(path: "testPath", thumbnailExtension: "testExtension")
        let hero = Hero(id: 1, name: "TestHero", description: "TestDescription", thumbnail: thumbnail)
        
        XCTAssertEqual(hero.id, 1)
        XCTAssertEqual(hero.name, "TestHero")
        XCTAssertEqual(hero.description, "TestDescription")
        XCTAssertEqual(hero.thumbnail.path, "testPath")
        XCTAssertEqual(hero.thumbnail.thumbnailExtension, "testExtension")
    }

    func testSerieModel() {
        let thumbnail = SerieThumbnail(path: "testPath", thumbnailExtension: "testExtension")
        let serie = Serie(id: 1, title: "TestSeries", description: "TestDescription", thumbnail: thumbnail)
        
        XCTAssertEqual(serie.id, 1)
        XCTAssertEqual(serie.title, "TestSeries")
        XCTAssertEqual(serie.description, "TestDescription")
        XCTAssertEqual(serie.thumbnail.path, "testPath")
        XCTAssertEqual(serie.thumbnail.thumbnailExtension, "testExtension")
    }
    
    func testHeroesViewModel() {
        let heroesViewModel = HeroesViewModel(interactor: TestHeroesInteractor())
        heroesViewModel.loadSampleData()

        XCTAssertEqual(heroesViewModel.heroes.count, 1)
        XCTAssertEqual(heroesViewModel.heroes[0].id, 1)
        XCTAssertEqual(heroesViewModel.heroes[0].name, "TestHero")
        XCTAssertEqual(heroesViewModel.heroes[0].description, "TestDescription")
        XCTAssertEqual(heroesViewModel.heroes[0].thumbnail.path, "testPath")
        XCTAssertEqual(heroesViewModel.heroes[0].thumbnail.thumbnailExtension, "testExtension")
    }

    func testSeriesViewModel() {
        let thumbnail = HeroeThumbnail(path: "testPath", thumbnailExtension: "testExtension")
        let hero = Hero(id: 1, name: "TestHero", description: "TestDescription", thumbnail: thumbnail)
        let seriesViewModel = SeriesViewModel(interactor: TestSeriesInteractor(), hero: hero)
        seriesViewModel.loadSampleData()
        

        XCTAssertEqual(seriesViewModel.series.count, 1)
        XCTAssertEqual(seriesViewModel.series[0].id, 1)
        XCTAssertEqual(seriesViewModel.series[0].title, "TestSeries")
        XCTAssertEqual(seriesViewModel.series[0].description, "TestDescription")
        XCTAssertEqual(seriesViewModel.series[0].thumbnail.path, "testPath")
        XCTAssertEqual(seriesViewModel.series[0].thumbnail.thumbnailExtension, "testExtension")
    }
}

class TestHeroesInteractor: HeroesInteractorProtocol {
    func getHeroes(filter: String) -> AnyPublisher<[Hero], Error> {
        let thumbnail = HeroeThumbnail(path: "testPath", thumbnailExtension: "testExtension")
        let hero = Hero(id: 1, name: "TestHero", description: "TestDescription", thumbnail: thumbnail)
        return Just([hero])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class TestSeriesInteractor: SeriesInteractorProtocol {
    func getSeries(for hero: Hero, limit: Int) -> AnyPublisher<[Serie], Error> {
        let thumbnail = SerieThumbnail(path: "testPath", thumbnailExtension: "testExtension")
        let serie = Serie(id: 1, title: "TestSeries", description: "TestDescription", thumbnail: thumbnail)
        return Just([serie])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}







