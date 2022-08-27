

import UIKit

@objc protocol ChangePasswordRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ChangePasswordDataPassing
{
  var dataStore: ChangePasswordDataStore? { get }
}

class ChangePasswordRouter: NSObject, ChangePasswordRoutingLogic, ChangePasswordDataPassing
{
  weak var viewController: ChangePasswordViewController?
  var dataStore: ChangePasswordDataStore?
  
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
  
  //func navigateToSomewhere(source: ChangePasswordViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ChangePasswordDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
