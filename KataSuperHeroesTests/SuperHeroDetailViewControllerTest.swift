//
//  SuperHeroDetailViewControllerTest.swift
//  KataSuperHeroesTests
//
//  Created by Óscar Manrique on 20/11/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import KIF
import Nimble
import UIKit
@testable import KataSuperHeroes

class SuperHeroDetailViewControllerTest: AcceptanceTestCase {
    
    fileprivate let repository = MockSuperHeroesRepository()
    fileprivate let superHero = SuperHero(name: "Eto",
        photo: NSURL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/60/55b6a28ef24fa.jpg") as URL?,
        isAvenger: true, description: "Description - Eto dfg gvasdg adsgaksdlga sdfaskljaslkdf asdf ")
    

    func testShowDescriptionIfThereLoadSuperHero() {
        openSuperHeroDetailViewController()
        
        tester().waitForView(withAccessibilityLabel: "Description: \(superHero.name)")
    }
    
    func testShowSuperHeroNameAsTitle() {
        
        openSuperHeroDetailViewController()
        
        tester().waitForView(withAccessibilityLabel: superHero.name, traits: UIAccessibilityTraitHeader)
    }
    
    fileprivate func openSuperHeroDetailViewController() {
        
        let superHeroName = superHero.name
        repository.superHeroes = [superHero]
        let superHeroDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(superHeroName)
            as! SuperHeroDetailViewController
        superHeroDetailViewController.presenter = SuperHeroDetailPresenter(ui: superHeroDetailViewController, superHeroName: superHeroName, getSuperHeroByName: GetSuperHeroByName(repository: repository))
        
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [superHeroDetailViewController]
        present(viewController: rootViewController)
        tester().waitForAnimationsToFinish()
    }
}
