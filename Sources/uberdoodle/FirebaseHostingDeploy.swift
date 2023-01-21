/**
*  Publish
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import Foundation
import Files
import Publish
import ShellOut

public extension DeploymentMethod {
    /// Deploy a website to a given remote using Git.
    /// - parameter remote: The full address of the remote to deploy to.
    static func firebaseHosting(_ project: String) -> Self {
        DeploymentMethod(name: "Firebase Hosting (\(project))") { context in
            do {
                try shellOut(
                    to: "firebase use \(project)",
                    at: ".",
                    outputHandle: FileHandle.standardOutput,
                    errorHandle: FileHandle.standardError
                )

                _ = try? shellOut(
                    to: "firebase deploy --only hosting",
                    at: ".",
                    outputHandle: FileHandle.standardOutput,
                    errorHandle: FileHandle.standardError
                )
            } catch let error as ShellOutError {
                throw PublishingError(infoMessage: error.message)
            } catch {
                throw error
            }

        }
    }
}
