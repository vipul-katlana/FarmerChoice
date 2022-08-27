

import UIKit

@objc protocol MapLocationRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MapLocationDataPassing
{
  var dataStore: MapLocationDataStore? { get }
}

class MapLocationRouter: NSObject, MapLocationRoutingLogic, MapLocationDataPassing
{
  weak var viewController: MapLocationViewController?
  var dataStore: MapLocationDataStore?
  
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
  
  //func navigateToSomewhere(source: MapLocationViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: MapLocationDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
