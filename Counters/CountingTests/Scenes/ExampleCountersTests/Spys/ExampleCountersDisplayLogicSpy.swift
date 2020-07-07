//
//  ExampleCountersDisplayLogicSpy.swift
//
//

class ExampleCountersDisplayLogicSpy: ExampleCountersDisplayLogic {
    var displayExamplesCalled = false
    var displayExamplesViewModel: ExampleCounters.Examples.ViewModel.Success?
    func displayExamples(viewModel: ExampleCounters.Examples.ViewModel.Success) {
        displayExamplesCalled = true
        displayExamplesViewModel = viewModel
    }


}
