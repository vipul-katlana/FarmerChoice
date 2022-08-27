
import UIKit

@objc protocol MyAccountDetailsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MyAccountDetailsDataPassing
{
  var dataStore: MyAccountDetailsDataStore? { get }
}

class MyAccountDetailsRouter: NSObject, MyAccountDetailsRoutingLogic, MyAccountDetailsDataPassing
{
  weak var viewController: MyAccountDetailsViewController?
  var dataStore: MyAccountDetailsDataStore?
  
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
  
  //func navigateToSomewhere(source: MyAccountDetailsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: MyAccountDetailsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
