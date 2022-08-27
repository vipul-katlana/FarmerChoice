

import UIKit

protocol MapLocationPresentationLogic
{
  func presentSomething(response: MapLocation.Something.Response)
}

class MapLocationPresenter: MapLocationPresentationLogic
{
  weak var viewController: MapLocationDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MapLocation.Something.Response)
  {
    let viewModel = MapLocation.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
