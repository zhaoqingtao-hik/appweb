/*
    secure.tst - SSL http tests
 */

if (!test || test.config["ssl"] == 1) {
    const HTTP = (global.session && session["http"]) || ":4100"
    const HTTPS = (global.session && session["https"]) || ":4100"
    let http: Http = new Http

    http.get(HTTP + "/index.html")
    assert(!http.isSecure)
    http.close()

    http.get(HTTPS + "/index.html")
    assert(http.isSecure)
    http.close()

    http.get(HTTPS + "/index.html")
    assert(http.readString(12) == "<html><head>")
    assert(http.readString(7) == "<title>")
    http.close()

    //  Validate get contents
    http.get(HTTPS + "/index.html")
    assert(http.response.endsWith("</html>\n"))
    assert(http.response.endsWith("</html>\n"))
    http.close()

    http.post(HTTPS + "/index.html", "Some data")
    assert(http.status == 200)
    http.close()

} else {
    test.skip("SSL not enabled")
}
