{
config,
pkgs,
lib,
}: 
let
  inherit (lib) enableOption mkIf types mkOption;
  cfg = config.services.xserver.displayManager.lemurs;
in {

  options.services.xserver.displayManager.lemurs = {
    enable = enableOption "Enables Lemur display manager";
    config = {
      path = {
        type = types.path;
        default = cfg.config.text;
      };
      text = mkOption {
        type = types.str;
        default = builtins.readFile ./config.toml;
      };
    };
  };

  config = mkIf cfg.enable {

    security.pam.services.lemurs = {
      text = ''
        #%PAM-1.0
        auth        include    login
        account     include    login
        session     include    login
        password    include    login
      '';
    };

    systemd.services.lemurs = {
      description = "Lemurs";
      after = [ "systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty2.service"];
      aliases = [ "display-manager.service" ];
      
      serviceConfig = {
        ExecStart = "${pkgs.lemurs}/bin/lemurs --config ${cfg.}";
        StandardInput= "tty";
        TTYPath = "/dev/tty2";
        TTYReset = "yes";
        TTYVHangup  = "yes";
        Type  = "idle";
      };
    };
  };
}