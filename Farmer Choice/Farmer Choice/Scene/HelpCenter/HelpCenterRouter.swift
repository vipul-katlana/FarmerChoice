

import UIKit

@objc protocol HelpCenterRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HelpCenterDataPassing
{
  var dataStore: HelpCenterDataStore? { get }
}

class HelpCenterRouter: NSObject, HelpCenterRoutingLogic, HelpCenterDataPassing
{
  weak var viewController: HelpCenterViewController?
  var dataStore: HelpCenterDataStore?
  
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
  
  //func navigateToSomewhere(source: HelpCenterViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: HelpCenterDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
