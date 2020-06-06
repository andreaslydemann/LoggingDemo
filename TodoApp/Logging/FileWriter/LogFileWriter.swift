import Foundation

final public class LogFileWriter: FileWriter {
    
    var filePath: String
    private var fileHandle: FileHandle?
    private var queue: DispatchQueue
    
    init(filePath: String) {
        self.filePath = filePath
        self.queue = DispatchQueue(label: "File output")
    }
    
    deinit {
        fileHandle?.closeFile()
    }
    
    public func write(_ message: String) {
        queue.sync(execute: {
            [weak self] in
            if let file = self?.getFileHandle() {
                let printed = message + "\n"
                if let data = printed.data(using: String.Encoding.utf8) {
                    file.seekToEndOfFile()
                    file.write(data)
                }
            }
        })
    }
    
    private func getFileHandle() -> FileHandle? {
        if fileHandle == nil {
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: filePath) {
                fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            
            fileHandle = FileHandle(forWritingAtPath: filePath)
        }
        
        return fileHandle
    }
}
