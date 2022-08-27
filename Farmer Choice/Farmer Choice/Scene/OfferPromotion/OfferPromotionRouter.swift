

import UIKit

@objc protocol OfferPromotionRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol OfferPromotionDataPassing
{
  var dataStore: OfferPromotionDataStore? { get }
}

class OfferPromotionRouter: NSObject, OfferPromotionRoutingLogic, OfferPromotionDataPassing
{
  weak var viewController: OfferPromotionViewController?
  var dataStore: OfferPromotionDataStore?
  
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
  
  //func navigateToSomewhere(source: OfferPromotionViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: OfferPromotionDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
