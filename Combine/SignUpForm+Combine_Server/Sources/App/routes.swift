import Vapor

func routes(_ app: Application) throws {
  app.get { req in
    return "It works!"
  }

  //hello라는 경로 /  Hello, world를 리턴함
  app.get("hello") { req -> String in
    return "Hello, world!"
  }

  //isUserNameAvailable라는 경로, userName 쿼리
  app.get("isUserNameAvailable") { req -> UserAvailable in
    let userName: String = req.query["userName"] ?? "unknown"
    let isAvailable = !["peterfriese", "johnnyappleseed", "page", "johndoe"].contains(userName)
    return UserAvailable(isAvailable: isAvailable, userName: userName )
  }
}
