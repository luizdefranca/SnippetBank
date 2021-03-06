//
//  SceneDelegate.swift
//  SnippetBank
//
//  Created by Luiz on 3/25/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        initializateSplitView()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    func initializateSplitView(){
        let splitViewController = UISplitViewController(style: .tripleColumn)
        splitViewController.delegate = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
        vc1.selectedTag = .persistence
        
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "SnippetTableViewController") as! SnippetTableViewController
        vc1.delegate = vc2
        vc2.selectedTag = .persistence
        
        let vc3 = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc2.delegate = vc3
        vc3.snippet = vc2.snippets.first
        
        splitViewController.preferredDisplayMode = UISplitViewController.DisplayMode.twoBesideSecondary
        
        splitViewController.setViewController(vc1, for: .primary)
        splitViewController.setViewController(vc2, for: .supplementary)
        splitViewController.setViewController(vc3, for: .secondary)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        .primary
    }
    
}
