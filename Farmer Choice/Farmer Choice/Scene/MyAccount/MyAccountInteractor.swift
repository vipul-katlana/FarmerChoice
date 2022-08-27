
import UIKit

protocol MyAccountBusinessLogic
{
  func doSomething(request: MyAccount.Something.Request)
}

protocol MyAccountDataStore
{
  //var name: String { get set }
}

class MyAccountInteractor: MyAccountBusinessLogic, MyAccountDataStore
{
  var presenter: MyAccountPresentationLogic?
  var worker: MyAccountWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MyAccount.Something.Request)
  {
    worker = MyAccountWorker()
    worker?.doSomeWork()
    
    let response = MyAccount.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
