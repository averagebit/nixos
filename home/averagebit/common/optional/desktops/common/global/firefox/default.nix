{
  config,
  pkgs,
  ...
}: {
  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".mozilla/firefox"];
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  home.sessionVariables = {MOZ_ENABLE_WAYLAND = 1;};

  programs.firefox = {
    enable = true;
    profiles."${config.home.username}" = {
      name = "${config.home.username}";
      isDefault = true;

      extensions.packages = with pkgs.inputs.firefox-addons; [
        bitwarden
        darkreader
        ublock-origin
        web-scrobbler
      ];

      search = {
        force = true;
        default = "DuckDuckGo";
        order = ["DuckDuckGo" "Phind"];
        engines = {
          "Nix Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@nw"];
          };
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@ho"];
          };
          "Phind" = {
            urls = [{template = "https://www.phind.com/search?q={searchTerms}";}];
            definedAliases = ["@ph"];
          };
        };
      };

      bookmarks = [
        {
          name = "Local";
          toolbar = false;
          bookmarks = [
            {
              name = "Router";
              tags = ["local"];
              keyword = "router";
              url = "https://router.home.arpa/";
            }
            {
              name = "Wi-Fi";
              tags = ["local"];
              keyword = "wifi";
              url = "https://wifi.home.arpa/";
            }
          ];
        }
        {
          name = "Services";
          toolbar = false;
          bookmarks = [
            {
              name = "Discord";
              tags = ["services"];
              keyword = "discord";
              url = "https://discord.com/app/";
            }
            {
              name = "Twitch";
              tags = ["services"];
              keyword = "twitch";
              url = "https://twitch.tv/";
            }
            {
              name = "Docker";
              tags = ["services"];
              keyword = "docker";
              url = "https://hub.docker.com/";
            }
            {
              name = "ChatGPT";
              tags = ["services"];
              keyword = "gpt";
              url = "https://chat.openai.com/";
            }
            {
              name = "GitHub";
              tags = ["services"];
              keyword = "gh";
              url = "https://github.com/";
            }
            {
              name = "Wire";
              tags = ["services"];
              keyword = "wire";
              url = "https://app.wire.com/";
            }
            {
              name = "NPM";
              tags = ["services"];
              keyword = "npm";
              url = "https://npmjs.com/";
            }
            {
              name = "Proton";
              tags = ["services"];
              keyword = "mail";
              url = "https://mail.proton.me/";
            }
            {
              name = "Cloudflare";
              tags = ["services"];
              keyword = "cf";
              url = "https://dash.cloudflare.com/";
            }
            {
              name = "Figma";
              tags = ["services"];
              keyword = "figma";
              url = "https://figma.com/files/";
            }
            {
              name = "Chess";
              tags = ["services"];
              keyword = "chess";
              url = "https://chess.com/";
            }
            {
              name = "Lichess";
              tags = ["services"];
              keyword = "lichess";
              url = "https://lichess.org/";
            }
            {
              name = "Spotify";
              tags = ["services"];
              keyword = "spotify";
              url = "https://open.spotify.com/";
            }
            {
              name = "Languagetool";
              tags = ["services"];
              keyword = "languagetool";
              url = "https://languagetool.org/";
            }
            {
              name = "Phind";
              tags = ["services"];
              keyword = "phind";
              url = "https://phind.com/";
            }
            {
              name = "Shodan";
              tags = ["services"];
              keyword = "shodan";
              url = "https://shodan.io/";
            }
            {
              name = "Greynoise";
              tags = ["services"];
              keyword = "greynoise";
              url = "https://greynoise.io/";
            }
            {
              name = "DNS Leak Test";
              tags = ["services"];
              keyword = "dnsleak";
              url = "https://dnsleaktest.com/";
            }
            {
              name = "Reddit";
              tags = ["services"];
              keyword = "reddit";
              url = "https://reddit.com/";
            }
            {
              name = "Google";
              tags = ["services"];
              keyword = "google";
              url = "https://google.com/";
            }
            {
              name = "YouTube";
              tags = ["services"];
              keyword = "yt";
              url = "https://youtube.com/";
            }
            {
              name = "DuckDuckGo";
              tags = ["services"];
              keyword = "ddg";
              url = "https://duckduckgo.com/";
            }
            {
              name = "Notion";
              tags = ["services"];
              keyword = "notion";
              url = "https://notion.so/";
            }
            {
              name = "Twitter";
              tags = ["services"];
              keyword = "x";
              url = "https://twitter.com/";
            }
          ];
        }
      ];

      settings = {
        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.cache.offline.enable" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.selfsupport.url" = "";
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 0;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.webaudio.enabled" = true;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.autoDisableScopes" = 14;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.greasemonkey.stats.optedin" = false;
        "extensions.greasemonkey.stats.url" = "";
        "extensions.pocket.enabled" = false;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "geo.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "media.autoplay.default" = 1;
        "media.autoplay.enabled" = false;
        "media.navigator.enabled" = false;
        "media.video_stats.enabled" = false;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "pdfjs.enableScripting" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.query_stripping" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.trackingproteution.cryptomining.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "security.ssl.disable_session_identifiers" = false;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "webgl.disabled" = false;
        "webgl.renderer-string-override" = " ";
        "webgl.vendor-string-override" = " ";
      };
    };
  };
}
