import com.typesafe.sbt.SbtScalariform
import com.typesafe.sbt.SbtScalariform.ScalariformKeys
import sbt.Keys._
import sbt._

import scalariform.formatter.preferences._

object hatenaInternExerciseBuild extends Build {
  val appName = "hatena-intern-exercise"
  val appVersion  = "0.0.1"
  val appScalaVersion = "2.11.6"

  val main = Project(
    appName,
    base = file("."),
    settings = Seq(
      version := appVersion,
      scalaVersion := appScalaVersion,
      libraryDependencies ++= Seq(
        "joda-time" % "joda-time" % "2.7",
        "org.joda" % "joda-convert" % "1.7",
        "org.scalatest" %% "scalatest" % "2.2.4" % "test",
        "com.github.scala-incubator.io" %% "scala-io-core" % "0.4.3",
        "com.github.scala-incubator.io" %% "scala-io-file" % "0.4.3"
        ),
      resolvers ++= Seq(
        "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/"
      ),
      fork in Test := true,
      scalacOptions in Test ++= Seq("-Yrangepos")
    ) ++  formatSettings
  ).settings(SbtScalariform.scalariformSettings: _*)

  lazy val formatSettings = Seq(
    ScalariformKeys.preferences := FormattingPreferences()
    .setPreference(IndentWithTabs, true)
    .setPreference(DoubleIndentClassDeclaration, true)
    .setPreference(PreserveDanglingCloseParenthesis, true)
  )
}
