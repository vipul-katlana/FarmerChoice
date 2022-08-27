

import UIKit

@objc protocol FeedBackRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol FeedBackDataPassing
{
  var dataStore: FeedBackDataStore? { get }
}

class FeedBackRouter: NSObject, FeedBackRoutingLogic, FeedBackDataPassing
{
  weak var viewController: FeedBackViewController?
  var dataStore: FeedBackDataStore?
  
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
  
  //func navigateToSomewhere(source: FeedBackViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: FeedBackDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
