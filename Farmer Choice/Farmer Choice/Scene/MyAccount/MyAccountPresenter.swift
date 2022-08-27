

import UIKit

protocol MyAccountPresentationLogic
{
  func presentSomething(response: MyAccount.Something.Response)
}

class MyAccountPresenter: MyAccountPresentationLogic
{
  weak var viewController: MyAccountDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MyAccount.Something.Response)
  {
    let viewModel = MyAccount.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
