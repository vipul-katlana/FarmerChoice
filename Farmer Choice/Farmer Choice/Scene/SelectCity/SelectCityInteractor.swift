
import UIKit

protocol SelectCityBusinessLogic
{
  func doSomething(request: SelectCity.Something.Request)
}

protocol SelectCityDataStore
{
  //var name: String { get set }
}

class SelectCityInteractor: SelectCityBusinessLogic, SelectCityDataStore
{
  var presenter: SelectCityPresentationLogic?
  var worker: SelectCityWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: SelectCity.Something.Request)
  {
    worker = SelectCityWorker()
    worker?.doSomeWork()
    
    let response = SelectCity.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
