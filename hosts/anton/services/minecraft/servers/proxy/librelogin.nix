{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mapAttrs' replaceStrings nameValuePair;
in {
  services.minecraft-servers.servers.proxy = {
    files = {
      "plugins/librelogin/config.conf".format = pkgs.formats.json {};
      "plugins/librelogin/config.conf".value = {
        allowed-commands-while-unauthorized = [
          "login"
          "register"
          "2fa"
          "2faconfirm"
        ];
        auto-register = false;
        database = {
          database = "minecraft";
          host = "localhost";
          max-life-time = 600000;
          password = "@MINECRAFT_DATABASE_PASSWORD@";
          port = 3306;
          user = "minecraft";
        };
        debug = false;
        default-crypto-provider = "BCrypt-2A";
        fallback = false;
        kick-on-wrong-password = false;
        limbo = ["limbo"];
        migration = {};
        milliseconds-to-refresh-notification = 10000;
        minimum-password-length = -1;
        new-uuid-creator = "MOJANG";
        pass-through = let
          velocityCfg = config.services.minecraft-servers.servers.proxy.files."velocity.toml".value;
        in
          {
            root = velocityCfg.servers.try;
          }
          // (
            mapAttrs'
            (n: nameValuePair (replaceStrings ["."] ["§"] n))
            velocityCfg.forced-hosts
          );
        ping-servers = true;
        remember-last-server = true;
        revision = 3;
        seconds-to-authorize = -1;
        session-timeout = 604800;
        totp.enabled = true;
        use-titles = false;
      };
      "plugins/librelogin/messages.conf".format = pkgs.formats.json {};
      "plugins/librelogin/messages.conf".value = {
        error-already-authorized = "&cYou are already authorized!";
        error-already-registered = "&cYou are already registered!";
        error-corrupted-configuration = "&cConfiguration is corrupted, old one is going to be kept. Cause: %cause%";
        error-corrupted-messages = "&cMessages are corrupted, old ones are going to be kept. Cause: %cause%";
        error-forbidden-password = "&cThe password is too short and/or is not allowed!";
        error-from-floodgate = "&cYou can't use this command from Floodgate!";
        error-invalid-syntax = "&cUse: <c2>{command}</c2> <c3>{syntax}</c3>";
        error-no-confirm = "&cPlease use /premium <password> first!";
        error-no-permission = "&cYou do not have permission to use this command!";
        error-not-authorized = "&cPlease authorize first!";
        error-not-available-on-multi-proxy = "&cThis feature is not available on MultiProxy!";
        error-not-cracked = "&cYou have autologin enabled, disable it using /cracked!";
        error-not-paid = "&cThis account does not exist in the Mojang database!";
        error-not-premium = "&cYou do not have autologin enabled, enable it using /premium <password>!";
        error-not-registered = "&cPlease register first!";
        error-occupied-user = "&cThis username is already occupied!";
        error-password-corrupted = "&cYour password is corrupted, please contact an administrator!";
        error-password-not-match = "&cPasswords do not match!";
        error-password-wrong = "&cWrong password!";
        error-player-authorized = "&cThis player is already authenticated!";
        error-player-not-registered = "&cThis player is not registered!";
        error-player-offline = "&cThis player is offline!";
        error-player-online = "&cThis player is online!";
        error-premium-throttled = "&cThe Mojang API is rate limiting our server, please try the command again in a while!";
        error-premium-unknown = "&cThere was an unknown error while communicating with the mojang API, please check console for further details!";
        error-throttle = "&cYou are sending commands too fast! Please wait a bit.";
        error-unknown = "&cAn unknown error occurred! Check console for further information.";
        error-unknown-command = "&cUnknown command!";
        error-unknown-user = "&cThis user does not exist!";
        error-wrong-mail-verify = "&cWrong verification code!";
        error-wrong-password-reset = "&cWrong password reset code!";
        info-deleted = "&aDeleted!";
        info-edited = "&aEdited!";
        info-kick = "&cYou have been kicked from the server for the following reason: %reason%";
        info-logged-in = "&aAuthenticated. Switch servers with: /server <name>";
        info-premium-logged-in = "&2Automatically authenticated. Switch servers with: /server <name>";
        info-registered = "&aRegistered! If you are on an original copy of the game, you can activate auto-login using: /premium";
        info-reloaded = "&aReloaded!";
        info-session-logged-in = "&aSession re-established. Switch servers with: /server <name>";
        info-user = "UUID: %uuid%\nPremium UUID: %premium_uuid%\nLast Seen: %last_seen%\nJoined: %joined%\n2FA: %2fa%\nEMail: %email%\nIP: %ip%\nLast Authenticated: %last_authenticated%";
        kick-2fa-enabled = "&aTwo-factor has been enabled! Please reconnect.";
        kick-error-password-wrong = "&cWrong password!";
        kick-illegal-username = "&cYou have illegal characters in your username or/and your username is longer than 16 characters!";
        kick-invalid-case-username = "&bPlease, change your username to &c%username%";
        kick-name-mismatch = "Oh no! It looks like a premium user with activated auto login changed their nickname to %nickname%, therefore there are 2 colliding accounts. Please contact the administrator.";
        kick-no-limbo = "&cThere's no available limbo to connect you to. Please try again later.";
        kick-no-lobby = "&cThere's no available lobby to connect you to. Please try again later.";
        kick-occupied-username = "&bPlease, change your username to &c%username%";
        kick-premium-error-throttled = "&cThe Mojang API is rate limiting our server, please try joining again in a while!";
        kick-premium-error-undefined = "&cThere was some issue while communicating with Mojang, if the problem persists, contact the server administrators!";
        kick-premium-info-disabled = "&aAutologin disabled!";
        kick-premium-info-enabled = "&aAutologin enabled!";
        kick-time-limit = "&eYou took too long to authorize!";
        prompt-confirm = "&bYou are about to enable premium autologin, please take note, that you &4WILL NOT&r be able to connect to your account from cracked client. You can turn this off later by using /cracked. To confirm this action, you have 5 minutes to run /confirmpremium";
        prompt-login = "&bPlease login using: &e/login &b<password> [2fa_code]";
        prompt-register = "&bPlease register using: &e/register &b<password> <password>";
        revision = 3;
        sub-title-login = "&e/login &b<password>";
        sub-title-register = "&e/register &b<password> <password>";
        syntax = {
          "2fa-confirm" = "<code>";
          change-password = "<oldPassword> <newPassword>";
          login = "<password> [2fa_code]";
          premium = "<password>";
          register = "<password> <passwordRepeat>";
          user-2fa-off = "<name>";
          user-cracked = "<name>";
          user-delete = "<name>";
          user-info = "<name>";
          user-login = "<name>";
          user-migrate = "<name> <newName>";
          user-pass-change = "<name> <newPassword>";
          user-premium = "<name>";
          user-register = "<name> <password>";
          user-unregister = "<name>";
        };
        title-login = "&6&lLogin";
        title-register = "&6&lRegister";
        totp-not-awaiting = "&cYou are currently not in the process of enabling 2FA! Please type /2fa to begin the process.";
        totp-not-provided = "&cYou must provide a 2FA code! Use /login <password> <2FA code>, if you lost your code, contact the admins.";
        totp-show-info = "&bPlease scan the QR code on the map into your 2FA app. For example, Google Authenticator or Authy.\nWhen you are complete, please execute the /2faconfirm <code> command to finish the process.\nDisconnect to abort.";
        totp-wrong = "&cWrong 2FA code!";
        totp-wrong-version = "You must connect with client version %low% - %high%, in order to enable 2FA. You can then connect back with old version again.";
      };
    };
    symlinks."plugins/LibreLogin.jar" = pkgs.fetchurl rec {
      pname = "LibreLogin";
      version = "0.18.3";
      url = "https://github.com/kyngs/${pname}/releases/download/${version}/${pname}.jar";
      hash = "sha256-n4np9Q4Ej3UMk314ozVc0idgaGzFBuLaZ0kRx7BfqxI=";
    };
  };
}
