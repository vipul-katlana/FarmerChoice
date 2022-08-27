

import UIKit

protocol ChangePasswordBusinessLogic
{
  func doSomething(request: ChangePassword.Something.Request)
}

protocol ChangePasswordDataStore
{
  //var name: String { get set }
}

class ChangePasswordInteractor: ChangePasswordBusinessLogic, ChangePasswordDataStore
{
  var presenter: ChangePasswordPresentationLogic?
  var worker: ChangePasswordWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: ChangePassword.Something.Request)
  {
    worker = ChangePasswordWorker()
    worker?.doSomeWork()
    
    let response = ChangePassword.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
