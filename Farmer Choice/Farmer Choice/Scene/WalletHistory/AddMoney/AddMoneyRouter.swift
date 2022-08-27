
import UIKit

@objc protocol AddMoneyRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AddMoneyDataPassing
{
  var dataStore: AddMoneyDataStore? { get }
}

class AddMoneyRouter: NSObject, AddMoneyRoutingLogic, AddMoneyDataPassing
{
  weak var viewController: AddMoneyViewController?
  var dataStore: AddMoneyDataStore?
  
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
  
  //func navigateToSomewhere(source: AddMoneyViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: AddMoneyDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
