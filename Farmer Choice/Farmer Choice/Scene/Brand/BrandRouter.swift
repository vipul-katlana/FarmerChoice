

import UIKit

@objc protocol BrandRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol BrandDataPassing
{
  var dataStore: BrandDataStore? { get }
}

class BrandRouter: NSObject, BrandRoutingLogic, BrandDataPassing
{
  weak var viewController: BrandViewController?
  var dataStore: BrandDataStore?
  
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
  
  //func navigateToSomewhere(source: BrandViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: BrandDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
