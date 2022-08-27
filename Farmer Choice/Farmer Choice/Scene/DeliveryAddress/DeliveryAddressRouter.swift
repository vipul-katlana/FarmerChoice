
import UIKit

@objc protocol DeliveryAddressRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DeliveryAddressDataPassing
{
  var dataStore: DeliveryAddressDataStore? { get }
}

class DeliveryAddressRouter: NSObject, DeliveryAddressRoutingLogic, DeliveryAddressDataPassing
{
  weak var viewController: DeliveryAddressViewController?
  var dataStore: DeliveryAddressDataStore?
  
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
  
  //func navigateToSomewhere(source: DeliveryAddressViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: DeliveryAddressDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
