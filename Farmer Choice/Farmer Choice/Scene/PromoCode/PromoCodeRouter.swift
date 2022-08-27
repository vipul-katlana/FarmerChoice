

import UIKit

@objc protocol PromoCodeRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PromoCodeDataPassing
{
  var dataStore: PromoCodeDataStore? { get }
}

class PromoCodeRouter: NSObject, PromoCodeRoutingLogic, PromoCodeDataPassing
{
  weak var viewController: PromoCodeViewController?
  var dataStore: PromoCodeDataStore?
  
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
  
  //func navigateToSomewhere(source: PromoCodeViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: PromoCodeDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
