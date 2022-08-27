

import UIKit

@objc protocol OrdersDetailsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OrdersDetailsDataPassing
{
  var dataStore: OrdersDetailsDataStore? { get }
}

class OrdersDetailsRouter: NSObject, OrdersDetailsRoutingLogic, OrdersDetailsDataPassing
{
  weak var viewController: OrdersDetailsViewController?
  var dataStore: OrdersDetailsDataStore?
  
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
  
  //func navigateToSomewhere(source: OrdersDetailsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: OrdersDetailsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
