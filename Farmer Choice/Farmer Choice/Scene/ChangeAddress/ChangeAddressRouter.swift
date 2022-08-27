

import UIKit

@objc protocol ChangeAddressRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ChangeAddressDataPassing
{
  var dataStore: ChangeAddressDataStore? { get }
}

class ChangeAddressRouter: NSObject, ChangeAddressRoutingLogic, ChangeAddressDataPassing
{
  weak var viewController: ChangeAddressViewController?
  var dataStore: ChangeAddressDataStore?
  
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
  
  //func navigateToSomewhere(source: ChangeAddressViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ChangeAddressDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
