//

user_pref("webgl.disabled", true);                                // PREF: Disable webGL
user_pref("webgl.disable-extensions", true);                      // PREF: When webGL is enabled, disable webGL extensions

user_pref("browser.send_pings", false);                           // PREF: Disable pinging URIs specified in HTML <a> ping= attributes
user_pref("browser.send_pings.require_same_host", true);          // PREF: When browser pings are enabled, only allow pinging the same host as the origin page

user_pref("browser.cache.disk.enable", false);                    // PREF: Disable disk caching
user_pref("browser.cache.disk_cache_ssl", false);                 // PREF: Disable ssl disk caching
user_pref("browser.cache.offline.capacity", 0);                   // PREF: Set offline cache disk capacity to zero
user_pref("browser.cache.offline.enable", false);                 // PREF: Do not download URLs for the offline cache

user_pref("beacon.enabled",	false);                               // PREF: Disable "beacon" asynchronous HTTP transfers (used for analytics)

user_pref("dom.event.clipboardevents.enabled", false);            // PREF: Disable clipboard event detection (onCut/onCopy/onPaste) via Javascript
user_pref("dom.allow_cut_copy", false);                           // PREF: Disable "copy to clipboard" functionality via Javascript (Firefox >= 41)
user_pref("dom.battery.enabled", false);                          // PREF: Disable battery API (Firefox < 52)
user_pref("dom.webnotifications.enabled", false);                 // PREF: Disable web notifications

user_pref("geo.enabled", false);                                  // PREF: Disable Location-Aware Browsing (geolocation)

user_pref("browser.fixup.alternate.enabled", false);              // PREF: Don't try to guess domain names when entering an invalid domain name in URL bar
user_pref("browser.download.animateNotifications", false);        // PREF: Disable download notification animation
user_pref("browser.newtabpage.enabled", false);                   // PREF: Disable the "new tab page" feature and show a blank tab instead
user_pref("browser.newtabpage.activity-stream.enabled", false);   // PREF: Disable Activity Stream

user_pref("layout.css.visited_links_enabled", false);             // PREF: Disable CSS :visited selectors

user_pref("browser.urlbar.maxRichResults", 0);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.searchSuggestionsChoice", false);
user_pref("browser.urlbar.timesBeforeHidingSuggestionsHint", 0);

user_pref("browser.discovery.enabled",  false);                   // PREF: Allow Firefox to make personalized extension recommendations
user_pref("browser.search.update",  false);                       // PREF: Never check updates for search engines

user_pref("app.shield.optoutstudies.enabled",	false);             // PREF: Disable SHIELD
user_pref("browser.pocket.enabled", false);                       // PREF: Disable Pocket

user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);

user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

user_pref("network.captive-portal-service.enabled", false);       // PREF: Disable automatic captive portal detection (Firefox >= 52.0)
user_pref("network.cookie.cookieBehavior", 1);
user_pref("network.cookie.lifetimePolicy", 2);
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.prefetch-next", false);                        // PREF: Disable prefetching of <link rel="next"> URLs

user_pref("network.dns.disablePrefetch",  true);                  // PREF: Disable DNS prefetching
user_pref("network.dns.disablePrefetchFromHTTPS", true);          // PREF: Disable DNS prefetching from HTTPS
user_pref("network.dns.disableIPv6", true);
user_pref("network.dnsCacheEntries", 0);

user_pref("network.http.speculative-parallel-limit", 0);          // PREF: Disable speculative pre-connections
user_pref("network.predictor.cleaned-up", true);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.proxy.socks_remote_dns", true);

user_pref("browser.tabs.crashReporting.sendReport", false);       // PREF: Disable sending reports of tab crashes to Mozilla
user_pref("breakpad.reportURL", "");                              // PREF: Disable crash report URL

user_pref("toolkit.telemetry.enabled", false);                    // PREF: Disable Mozilla telemetry
user_pref("toolkit.telemetry.unified",  false);
user_pref("toolkit.telemetry.archive.enabled", false);

user_pref("devtools.cache.disabled", true);                       // PREF: Disable caching when dev tools is open
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.dom.enabled", true);
user_pref("devtools.command-button-measure.enabled", true);
user_pref("devtools.command-button-paintflashing.enabled", true);
user_pref("devtools.command-button-rulers.enabled", true);
user_pref("devtools.command-button-screenshot.enabled", true);

user_pref("dom.maxHardwareConcurrency", 2);                       // PREF: Spoof dual-core CPU https://bugzilla.mozilla.org/show_bug.cgi?id=1360039
