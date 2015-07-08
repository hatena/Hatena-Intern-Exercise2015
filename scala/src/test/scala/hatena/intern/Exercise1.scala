package hatena.intern

import hatena.intern.helper._

class Exercise1Spec extends UnitSpec {

  describe("Log class") {
    it("Logクラスのメソッドが正しく実装されている") {

      val log = Log(
        host = "127.0.0.1",
        user = "frank",
        epoch = 1372694390,
        req = "GET /apache_pb.gif HTTP/1.0",
        status = 200,
        size = 2326,
        referer = "http://www.hatena.ne.jp/"
      )

      log.method shouldBe "GET"
      log.path shouldBe "/apache_pb.gif"
      log.protocol shouldBe "HTTP/1.0"
      log.uri shouldBe "http://127.0.0.1/apache_pb.gif"
      log.time shouldBe "2013-07-01T15:59:50"

    }
  }

}
