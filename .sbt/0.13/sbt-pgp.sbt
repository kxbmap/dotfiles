import com.typesafe.sbt.pgp.PgpKeys._
import java.util.Locale.{ENGLISH => en}

useGpg := true

lazy val isWindows = sys.props.get("os.name").exists(_.toLowerCase(en).contains("windows"))

pgpSecretRing := {
  if (isWindows)
    file(sys.env("APPDATA")) / "gnupg" / "secring.gpg"
  else
    pgpSecretRing.value
}

pgpPublicRing := {
  if (isWindows)
    file(sys.env("APPDATA")) / "gnupg" / "pubring.gpg"
  else
    pgpPublicRing.value
}
