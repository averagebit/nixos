{lib, ...}: {
  time.timeZone = lib.mkDefault "Etc/UTC";
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales =
      lib.mkDefault ["en_US.UTF-8/UTF-8" "en_GB.UTF-8/UTF-8" "eu_ES.UTF-8/UTF-8"];
    extraLocaleSettings = {LC_MONETARY = lib.mkDefault "en_GB.UTF-8";};
  };
  console.keyMap = lib.mkDefault "us";
}
