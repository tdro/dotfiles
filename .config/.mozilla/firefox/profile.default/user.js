// User configuration (https://searchfox.org/mozilla-release/source/browser/app/profile/firefox.js)

user_pref("accessibility.typeaheadfind.flashBar", 0);                       // Disable flashing on CTRL+F

user_pref("app.normandy.api_url", "");                                      // Disable user studies
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.first_run", false);
user_pref("app.normandy.user_id", "");

user_pref("app.shield.optoutstudies.enabled", false);                       // Opt out of user studies
user_pref("app.update.auto", false);                                        // Disable automatic updates

user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("places.history.enabled", false);

user_pref("browser.aboutConfig.showWarning", false);                        // Disable about:config warning
user_pref("browser.discovery.enabled", false);                              // Disable extension recommendations
user_pref("browser.fixup.alternate.enabled", false);                        // Disable URL fixing
user_pref("browser.formfill.enable", false);                                // Disable form history
user_pref("browser.pocket.enabled", false);                                 // Disable pocket
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);           // Memory only private browsing media cache
user_pref("browser.startup.homepage", "about:blank");                       // Set home page to about:blank
user_pref("browser.compactmode.show", true);                                // Enable legacy compact mode
user_pref("browser.uidensity", 1);                                          // Compact user interface
user_pref("browser.aboutHomeSnippets.updateUrl", "");                       // Disable home page promotions
user_pref("browser.contentblocking.category", "custom");
user_pref("browser.engagement.downloads-button.has-used", true);
user_pref("browser.engagement.home-button.has-used", true);
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);
user_pref("browser.toolbars.bookmarks.visibility", "never");                // Don't show bookmark toolbar
user_pref("browser.translations.panelShown", true);
user_pref("browser.disableResetPrompt", true);
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);

user_pref("browser.cache.disk.enable", false);                              // Disable disk cache
user_pref("browser.cache.disk_cache_ssl", false);
user_pref("browser.cache.memory.capacity", 25600);
user_pref("browser.cache.offline.capacity", 0);
user_pref("browser.cache.offline.enable", false);

user_pref("browser.chrome.site_icons", false);

user_pref("browser.bookmarks.defaultLocation", "unfiled");
user_pref("browser.bookmarks.restore_default_bookmarks", false);

user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.shortcuts", false);
user_pref("browser.ml.chat.sidebar", false);
user_pref("browser.ml.chat.provider", "");

user_pref("print.more-settings.open", true);                                // Show all printer settings

user_pref("media.videocontrols.picture-in-picture.video-toggle.has-used", true);

user_pref("extensions.update.autoUpdateDefault", false);
user_pref("extensions.webcompat.enable_shims", true);                       // (https://searchfox.org/mozilla-central/source/browser/extensions/webcompat/shims)
user_pref("extensions.webcompat.perform_injections", true);
user_pref("extensions.webcompat.perform_ua_overrides", true);
user_pref("extensions.webcompat.enable_picture_in_picture_overrides", true);

user_pref("browser.download.alwaysOpenPanel", false);                       // Disable opening panel on download
user_pref("browser.download.always_ask_before_handling_new_types", true);   // Always ask for new mime types
user_pref("browser.download.animateNotifications", false);                  // Disable download animations
user_pref("browser.download.manager.addToRecentDocs", false);               // Disable adding download to recent list
user_pref("browser.download.useDownloadDir", false);                        // Always ask where to save download
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.panel.shown", true);

user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);

user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.pinned", "");

user_pref("browser.newtabpage.activity-stream.impressionId", "");
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.endpoint", "");  // Disable firefox suggest activity stream endpoint

user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);

user_pref("browser.search.region", "US");
user_pref("browser.search.geoip.url", "");
user_pref("browser.search.update", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.search.suggest.enabled.private", false);
user_pref("browser.search.serpEventTelemetryCategorization.enabled", false);

user_pref("browser.startup.homepage_override.mstone", "ignore");        // Disable welcome screen
user_pref("browser.startup.page", 3);                                   // Resume the previous browser session

user_pref("browser.send_pings", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.disableResetPrompt", true);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
user_pref("browser.send_pings.require_same_host", true);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);     // Disable what's new panel
user_pref("browser.sessionstore.privacy_level", 2);
user_pref("browser.sessionhistory.max_entries", 20);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.tabs.loadInBackground", false);

user_pref("browser.urlbar.maxRichResults", 0);
user_pref("browser.urlbar.searchSuggestionsChoice", false);
user_pref("browser.urlbar.showSearchTerms.enabled", false);             // Always show URL
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.suggest.recentsearches", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.timesBeforeHidingSuggestionsHint", 0);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.merino.endpointURL", "");                     // Disable firefox suggest endpoint

user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.usage.uploadEnabled", false);

user_pref("device.sensors.ambientLight.enabled", false);
user_pref("device.sensors.enabled", false);
user_pref("device.sensors.motion.enabled", false);
user_pref("device.sensors.orientation.enabled", false);
user_pref("device.sensors.proximity.enabled", false);

user_pref("devtools.everOpened", true);
user_pref("devtools.debugger.breakpoints-visible", false);
user_pref("devtools.debugger.event-listeners-visible", true);
user_pref("devtools.debugger.ignore-caught-exceptions", false);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.debugger.ui.editor-wrapping", true);

user_pref("devtools.aboutdebugging.collapsibilities.processes", false);
user_pref("devtools.layout.flex-container.opened", false);
user_pref("devtools.layout.flexbox.opened", false);
user_pref("devtools.layout.grid.opened", false);
user_pref("devtools.onboarding.telemetry.logged", true);
user_pref("devtools.responsive.reloadNotification.enabled", false);
user_pref("devtools.responsive.show-setting-tooltip", false);
user_pref("devtools.responsive.touchSimulation.enabled", true);
user_pref("devtools.screenshot.audio.enabled", false);
user_pref("devtools.webide.autoinstallADBExtension", false);

user_pref("devtools.cache.disabled", true);
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.dom.enabled", true);

user_pref("devtools.command-button-measure.enabled", true);
user_pref("devtools.command-button-paintflashing.enabled", true);
user_pref("devtools.command-button-rulers.enabled", true);
user_pref("devtools.command-button-screenshot.enabled", true);

user_pref("devtools.webconsole.filter.css", true);
user_pref("devtools.webconsole.filter.net", true);
user_pref("devtools.webconsole.filter.netxhr", true);
user_pref("devtools.webconsole.input.editor", true);
user_pref("devtools.webconsole.input.editorOnboarding", false);
user_pref("devtools.webconsole.persistlog", true);                         // Persist logs between loads.
user_pref("devtools.webconsole.timestampMessages", true);                  // Persist timestamps between loads.

user_pref("devtools.inspector.activeSidebar", "ruleview");
user_pref("devtools.inspector.selectedSidebar", "ruleview");
user_pref("devtools.inspector.show-three-pane-tooltip", false);
user_pref("devtools.inspector.showAllAnonymousContent", true);
user_pref("devtools.inspector.showUserAgentStyles", true);
user_pref("devtools.inspector.show_pseudo_elements", true);
user_pref("devtools.inspector.three-pane-enabled", false);
user_pref("devtools.inspector.three-pane-first-run", false);

user_pref("dom.allow_cut_copy", false);
user_pref("dom.battery.enabled", false);
user_pref("dom.event.clipboardevents.enabled", false);
user_pref("dom.event.contextmenu.enabled", false);
user_pref("dom.maxHardwareConcurrency", 2);
user_pref("dom.popup_allowed_events", "");
user_pref("dom.push.connection.enabled", false);                           // Disable web push notifications
user_pref("dom.push.enabled", false);
user_pref("dom.push.userAgentID", "");
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);

user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);                         // Disable recommendations pane
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);    // Disable addons recommendations
user_pref("extensions.pocket.enabled", false);                             // Disable read it later service
user_pref("extensions.screenshots.upload-disabled", true);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.webservice.discoverURL", "");

user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("experiments.activeExperiment", false);

user_pref("general.smoothScroll", false);
user_pref("findbar.highlightAll", true);
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "");
user_pref("gfx.webrender.all", true);
user_pref("javascript.options.mem.max", 51200);
user_pref("layout.css.visited_links_enabled", false);                      // Disable visited links

user_pref("media.autoplay.default", 1);
user_pref("media.ffvpx.enabled", false);
user_pref("media.autoplay.enabled", false);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffmpeg.dmabuf-textures.enabled", true);
user_pref("media.peerconnection.enabled", false);                          // Disable WebRTC

user_pref("network.IDN_show_punycode", true);                              // Show deobfuscated URLs
user_pref("network.allow-experiments", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);                  // Disable network connectivity check
user_pref("network.cookie.cookieBehavior", 1);
user_pref("network.cookie.lifetimePolicy", 2);
user_pref("network.cookie.thirdparty.sessionOnly", true);
user_pref("network.dns.disableIPv6", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.dnsCacheEntries", 0);
user_pref("network.http.referer.spoofSource", true);
user_pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.predictor.cleaned-up", true);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.predictor.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.trr.mode", 5);

user_pref("network.proxy.socks_remote_dns", true);                         // Use proxy for DNS
user_pref("network.proxy.backup.ssl", "127.0.0.1");
user_pref("network.proxy.backup.ssl_port", 3128);
user_pref("network.proxy.http", "127.0.0.1");
user_pref("network.proxy.http_port", 3128);
user_pref("network.proxy.share_proxy_settings", true);
user_pref("network.proxy.socks", "127.0.0.1");
user_pref("network.proxy.ssl", "127.0.0.1");
user_pref("network.proxy.ssl_port", 3128);

user_pref("security.OCSP.enabled", 0);
user_pref("security.ssl.disable_session_identifiers", true);

user_pref("sidebar.main.tools", "");
user_pref("sidebar.visibility", "hide-sidebar");

user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);    // Allow legacy customizations
user_pref("toolkit.cosmeticAnimations.enabled", false);

user_pref("signon.autofillForms", false);
user_pref("signon.rememberSignons", false);
user_pref("signon.generation.enabled", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.firefoxRelay.feature", "disabled");                      // Disable relay email masks

user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

user_pref("privacy.history.custom", true);
user_pref("privacy.donottrackheader.enabled", false);                      // Do not ask nicely not to track
user_pref("privacy.annotate_channels.strict_list.enabled", true);
user_pref("privacy.cpd.offlineApps", true);
user_pref("privacy.cpd.siteSettings", true);
user_pref("privacy.popups.showBrowserMessage", false);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.query_stripping.enabled.pbmode", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.sanitize.timeSpan", 0);

user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.formdata", true);
user_pref("privacy.clearOnShutdown.offlineApps", true);
user_pref("privacy.clearOnShutdown.sessions", true);

user_pref("privacy.userContext.enabled", true);                            // Enable contextual identity containers
user_pref("privacy.userContext.longPressBehavior", 2);
user_pref("privacy.userContext.ui.enabled", true);
user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);

user_pref("privacy.clearHistory.browsingHistoryAndDownloads", true);
user_pref("privacy.clearHistory.cache", true);
user_pref("privacy.clearHistory.cookiesAndStorage", true);
user_pref("privacy.clearHistory.formdata", true);
user_pref("privacy.clearHistory.historyFormDataAndDownloads", true);
user_pref("privacy.clearHistory.siteSettings", true);

user_pref("webgl.disable-extensions", true);
user_pref("webgl.disabled", true);
user_pref("webgl.renderer-string-override", "");
user_pref("webgl.vendor-string-override", "");
