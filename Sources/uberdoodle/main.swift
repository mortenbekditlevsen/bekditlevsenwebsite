import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct Uberdoodle: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case swiftEvolution = "swift-evolution"
        case firebase
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://bekditlevsen.dk")!
    var name = "bekditlevsen.dk"
    var description = "A spirograph drawing tool for iPad and iPhone"
    var language: Language { .english }
    var imagePath: Path? { "Resources/appclip2.jpg" }
}

// This will generate your website using the built-in Foundation theme:
try Uberdoodle()
    .publish(withTheme: .uberdoodle,
             deployedUsing: .firebaseHosting("bekditlevsen"),
             additionalSteps: [
                .copyResources(at: "Resources/.well-known", to: ".well-known", includingFolder: false),
//                .addItem(Item(
//                    path: "my-favorite-recipe",
//                    sectionID: .posts,
//                    metadata: Uberdoodle.ItemMetadata(),
//                    tags: ["favorite", "featured"],
//                    content: Content(
//                        title: "Check out my favorite recipe!"
//                    )
//                )),
             ],
             plugins: [.splash(withClassPrefix: "mojo-")])

