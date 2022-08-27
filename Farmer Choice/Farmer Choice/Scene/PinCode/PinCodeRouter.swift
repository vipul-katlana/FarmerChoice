
import UIKit

@objc protocol PinCodeRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PinCodeDataPassing
{
  var dataStore: PinCodeDataStore? { get }
}

class PinCodeRouter: NSObject, PinCodeRoutingLogic, PinCodeDataPassing
{
  weak var viewController: PinCodeViewController?
  var dataStore: PinCodeDataStore?
  
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
  
  //func navigateToSomewhere(source: PinCodeViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: PinCodeDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
