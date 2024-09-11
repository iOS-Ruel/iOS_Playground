import ProjectDescription

let project = Project(
    name: "Albertos",
    targets: [
        .target(
            name: "Albertos",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Albertos",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Albertos/Sources/**"],
            resources: ["Albertos/Resources/**"],
            dependencies: [
                .project(target: "HippoPayments",
                         path: .path("HippoPayments"),
                         condition: .none
                )
            ]
        ),
        .target(
            name: "AlbertosTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.AlbertosTests",
            infoPlist: .default,
            sources: ["Albertos/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Albertos")]
        ),
    ]
)
