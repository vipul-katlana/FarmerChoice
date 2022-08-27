

import UIKit

protocol SelectCityPresentationLogic
{
  func presentSomething(response: SelectCity.Something.Response)
}

class SelectCityPresenter: SelectCityPresentationLogic
{
  weak var viewController: SelectCityDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: SelectCity.Something.Response)
  {
    let viewModel = SelectCity.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
