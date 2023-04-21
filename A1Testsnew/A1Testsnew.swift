//
//  A1Testsnew.swift
//  A1Testsnew
//
//  Created by Tsz Hoi Leung on 17/4/2023.
//

import XCTest
@testable import A1

final class A1Testsnew: XCTestCase {
    
    var viewModel: ChecklistViewModel!
    
    override func setUp() {
            super.setUp()
            viewModel = ChecklistViewModel()
        }

        override func tearDown() {
            viewModel = nil
            super.tearDown()
        }
    
    func testAddItem() {
        
        let viewModel = ChecklistViewModel()
        let initialCount = viewModel.items.count
        
        viewModel.addItems()
        
        XCTAssertEqual(viewModel.items.count, initialCount + 1)
    }
    
    func testDeleteItem() {
        
           let viewModel = ChecklistViewModel()
           let itemToDelete = viewModel.items[0]

           viewModel.deleteItems(at: IndexSet([0]))

           XCTAssertFalse(viewModel.items.contains(itemToDelete))
       }
    
    func testContentView() {

        let viewModel = ChecklistViewModel()
        let contentView = ContentView(viewModel: viewModel)
        

        XCTAssertNotNil(contentView)
    }
    
    func testItemDetailView() {

        let viewModel = ChecklistViewModel()
        let item = ChecklistItem(name: "Test Item", isChecked: false, detail: "Test Detail")
        let itemDetailView = ItemDetailView(viewModel: viewModel, item: item)
        

        XCTAssertNotNil(itemDetailView)
    }
    
    func testResetCheck() {
        let initialCheckmarks = viewModel.items.map({ $0.isChecked })
        viewModel.resetCheck()
        let resetCheckmarks = viewModel.items.map({ $0.isChecked })
        XCTAssertNotEqual(initialCheckmarks, resetCheckmarks)
        XCTAssertEqual(resetCheckmarks, [false, false, false, false])
    }
    
    func testDefaultItems() {
        XCTAssertEqual(viewModel.items.count, 4)
        XCTAssertEqual(viewModel.items.first?.name, "Buy groceries")
        XCTAssertEqual(viewModel.items.last?.name, "Exercise")
    }
    
    func testSwipeToDelete() {
        let initialItemCount = viewModel.items.count
        viewModel.deleteItems(at: IndexSet(integer: 0))
        XCTAssertEqual(viewModel.items.count, initialItemCount - 1)
    }
    
    func testSaveAndLoad() {
        let newItem = ChecklistItem(name: "New routine", isChecked: false, detail: "routine detail")
        viewModel.items.append(newItem)
        viewModel.saveItems()
        
        let newViewModel = ChecklistViewModel()
        newViewModel.loadItems()
        XCTAssertEqual(newViewModel.items.count, 5)
        XCTAssertEqual(newViewModel.items.last?.name, "New routine")
        
        
    }



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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
