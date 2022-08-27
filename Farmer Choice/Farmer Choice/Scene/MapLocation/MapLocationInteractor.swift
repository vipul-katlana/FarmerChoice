

import UIKit

protocol MapLocationBusinessLogic
{
  func doSomething(request: MapLocation.Something.Request)
}

protocol MapLocationDataStore
{
  //var name: String { get set }
}

class MapLocationInteractor: MapLocationBusinessLogic, MapLocationDataStore
{
  var presenter: MapLocationPresentationLogic?
  var worker: MapLocationWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MapLocation.Something.Request)
  {
    worker = MapLocationWorker()
    worker?.doSomeWork()
    
    let response = MapLocation.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
