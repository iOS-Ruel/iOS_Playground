import ProjectDescription

let project = Project(
    name: "HippoPayments",
    targets: [
        .target(name: "HippoPayments",
                destinations: .iOS,
                product: .framework,
                bundleId: "kr.co.codegrove.HippoPayments",
                infoPlist: .default,
                sources: ["Sources/**"],
                dependencies: []
               )
    ]
)
