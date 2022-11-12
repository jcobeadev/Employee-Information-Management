//
//  SceneDelegate.swift
//  Employee Information Management App
//
//  Created by Jayco Bea on 11/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window

        self.appCoordinator = AppCoordinator(window: window)
        appCoordinator? .start()

        createJSONIfDoesNotExist()
    }

    private func createJSONIfDoesNotExist() {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )

            let companiesSubURL = documentDirectory.appendingPathComponent("Companies.json")
            let employeesSubURL = documentDirectory.appendingPathComponent("Employees.json")
            print(companiesSubURL)

            createFileIfDoesNotExist(url: companiesSubURL)
            createFileIfDoesNotExist(url: employeesSubURL)
        } catch {
            print(error)
        }
    }

    private func createFileIfDoesNotExist(url: URL) {
        guard !FileManager.default.fileExists(atPath: url.path) else { return }

        FileManager.default.createFile(atPath: url.path, contents: nil)
    }
}
