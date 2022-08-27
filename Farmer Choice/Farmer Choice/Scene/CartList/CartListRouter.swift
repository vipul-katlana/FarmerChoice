

import UIKit

@objc protocol CartListRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CartListDataPassing
{
  var dataStore: CartListDataStore? { get }
}

class CartListRouter: NSObject, CartListRoutingLogic, CartListDataPassing
{
  weak var viewController: CartListViewController?
  var dataStore: CartListDataStore?
  
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
  
  //func navigateToSomewhere(source: CartListViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: CartListDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
