
import UIKit

@objc protocol WishListRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol WishListDataPassing
{
  var dataStore: WishListDataStore? { get }
}

class WishListRouter: NSObject, WishListRoutingLogic, WishListDataPassing
{
  weak var viewController: WishListViewController?
  var dataStore: WishListDataStore?
  
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
  
  //func navigateToSomewhere(source: WishListViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: WishListDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
