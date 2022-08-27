

import UIKit

@objc protocol ReferEarnRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ReferEarnDataPassing
{
  var dataStore: ReferEarnDataStore? { get }
}

class ReferEarnRouter: NSObject, ReferEarnRoutingLogic, ReferEarnDataPassing
{
  weak var viewController: ReferEarnViewController?
  var dataStore: ReferEarnDataStore?
  
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
  
  //func navigateToSomewhere(source: ReferEarnViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ReferEarnDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
