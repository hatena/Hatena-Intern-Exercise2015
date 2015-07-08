package hatena.intern

case class Log(host: String, user: String, epoch: Int, req: String, status: Int, size: Int, referer: String) {
  def method: String = ???
  def path: String = ???
  def protocol: String = ???
  def uri: String = ???
  def time: String = ???
}
