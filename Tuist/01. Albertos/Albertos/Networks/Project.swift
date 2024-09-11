import ProjectDescription

let project = Project(
    name: "Networks",
    targets: [
        .target(name: "Networks",
                destinations: .iOS,
                product: .framework,
                bundleId: "kr.co.codegrove.Albertos.Networks",
                infoPlist: .default,
                sources: ["Sources/**"],
                dependencies: []
               )
    ]
)
