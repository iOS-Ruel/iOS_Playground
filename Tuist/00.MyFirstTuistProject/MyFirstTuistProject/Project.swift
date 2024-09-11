import ProjectDescription

let project = Project(
    name: "MyFirstTuistProject",
    targets: [
        .target(
            name: "MyFirstTuistProject",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.MyFirstTuistProject",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["MyFirstTuistProject/Sources/**"],
            resources: ["MyFirstTuistProject/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "MyFirstTuistProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.MyFirstTuistProjectTests",
            infoPlist: .default,
            sources: ["MyFirstTuistProject/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MyFirstTuistProject")]
        ),
    ]
)
