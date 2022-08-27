

import UIKit

@objc protocol AuthenticationRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AuthenticationDataPassing
{
  var dataStore: AuthenticationDataStore? { get }
}

class AuthenticationRouter: NSObject, AuthenticationRoutingLogic, AuthenticationDataPassing
{
  weak var viewController: AuthenticationViewController?
  var dataStore: AuthenticationDataStore?
  
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
  
  //func navigateToSomewhere(source: AuthenticationViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: AuthenticationDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
