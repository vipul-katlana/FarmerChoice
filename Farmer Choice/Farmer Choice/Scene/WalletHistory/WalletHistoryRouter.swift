
import UIKit

@objc protocol WalletHistoryRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol WalletHistoryDataPassing
{
  var dataStore: WalletHistoryDataStore? { get }
}

class WalletHistoryRouter: NSObject, WalletHistoryRoutingLogic, WalletHistoryDataPassing
{
  weak var viewController: WalletHistoryViewController?
  var dataStore: WalletHistoryDataStore?
  
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
  
  //func navigateToSomewhere(source: WalletHistoryViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: WalletHistoryDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
