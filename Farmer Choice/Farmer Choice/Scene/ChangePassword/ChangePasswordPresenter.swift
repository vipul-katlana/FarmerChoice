

import UIKit

protocol ChangePasswordPresentationLogic
{
  func presentSomething(response: ChangePassword.Something.Response)
}

class ChangePasswordPresenter: ChangePasswordPresentationLogic
{
  weak var viewController: ChangePasswordDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ChangePassword.Something.Response)
  {
    let viewModel = ChangePassword.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
