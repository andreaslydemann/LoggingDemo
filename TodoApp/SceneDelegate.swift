import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        defer { self.window = window }

        window.windowScene = windowScene
        
        let logDateFormatter = LogDateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ssSSS")
        LogService.register(provider: ConsoleLogProvider(dateFormatter: logDateFormatter))
        LogService.register(provider: FileLogProvider(dateFormatter: logDateFormatter,
                                                      fileWriter: LogFileWriter(filePath: "/Users/andreaslydemann/Desktop/MyLog.txt")))

        let categoryVC = CategoryViewController(coreDataConnection: .shared, logService: .shared)
        
        window.rootViewController = UINavigationController(rootViewController: categoryVC)
        window.makeKeyAndVisible()
    }
}
