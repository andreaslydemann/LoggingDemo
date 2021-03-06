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
        
        let documentsUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first! as NSURL
        let logPath = documentsUrl.appendingPathComponent("app.log")
        
        if let lp = logPath {
            
            let path = lp.absoluteString.replacingOccurrences(of: "file://", with: "")
            
            let fileLog = FileLogProvider(dateFormatter: logDateFormatter,
                                          fileWriter: LogFileWriter(filePath:path))
                .filterToLogLevel(minimumLogLevel: .info)
            
            LogService.register(provider: fileLog)
            
            LogService.shared.debug("FileLogProvider path: [\(path)]")
        }

        let categoryVC = CategoryViewController(coreDataConnection: .shared, logService: .shared)
        
        window.rootViewController = UINavigationController(rootViewController: categoryVC)
        window.makeKeyAndVisible()
    }
}
