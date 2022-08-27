

import UIKit

@objc protocol OrderHistoryRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OrderHistoryDataPassing
{
  var dataStore: OrderHistoryDataStore? { get }
}

class OrderHistoryRouter: NSObject, OrderHistoryRoutingLogic, OrderHistoryDataPassing
{
  weak var viewController: OrderHistoryViewController?
  var dataStore: OrderHistoryDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: OrderHistoryViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: OrderHistoryDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
