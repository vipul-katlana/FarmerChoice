

import UIKit

@objc protocol OTPRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OTPDataPassing
{
  var dataStore: OTPDataStore? { get }
}

class OTPRouter: NSObject, OTPRoutingLogic, OTPDataPassing
{
  weak var viewController: OTPViewController?
  var dataStore: OTPDataStore?
  
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
  
  //func navigateToSomewhere(source: OTPViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: OTPDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
