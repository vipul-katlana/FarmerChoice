
import UIKit

@objc protocol DashBoardRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DashBoardDataPassing
{
  var dataStore: DashBoardDataStore? { get }
}

class DashBoardRouter: NSObject, DashBoardRoutingLogic, DashBoardDataPassing
{
  weak var viewController: DashBoardViewController?
  var dataStore: DashBoardDataStore?
  
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
  
  //func navigateToSomewhere(source: DashBoardViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: DashBoardDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
