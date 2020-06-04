import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene
        
        LogService.register(provider: ConsoleLogProvider())
        LogService.register(provider: FileLogProvider(filePath: "/Users/andreaslydemann/Desktop"))

        let categoryVC = CategoryViewController(coreDataConnection: .shared, logService: .shared)
        
        window.rootViewController = UINavigationController(rootViewController: categoryVC)
        window.makeKeyAndVisible()
    }
}
