
import UIKit

@objc protocol StaticPagesRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol StaticPagesDataPassing
{
  var dataStore: StaticPagesDataStore? { get }
}

class StaticPagesRouter: NSObject, StaticPagesRoutingLogic, StaticPagesDataPassing
{
  weak var viewController: StaticPagesViewController?
  var dataStore: StaticPagesDataStore?
  
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
  
  //func navigateToSomewhere(source: StaticPagesViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: StaticPagesDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
