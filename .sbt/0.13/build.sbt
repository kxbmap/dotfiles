import com.typesafe.sbt.SbtGit._

transitiveClassifiers in Global := Seq(Artifact.SourceClassifier)

//useJGit

showCurrentGitBranch

graphSettings
