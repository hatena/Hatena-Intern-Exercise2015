package hatena.intern

case class LogCounter(logs: Iterable[Log]) {
  def countError: Int = ???

  type User = String
  def groupByUser: Map[User, Iterable[Log]] = ???
}
