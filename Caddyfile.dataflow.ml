dataflow.ml:8080 {
  tls off
  redir 301 {
    /  https://{host}{uri}
  }
}

dataflow.ml:4443 {
  redir https://intel.github.io/dffml
}
