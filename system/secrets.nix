{ self, ... }:

{
  sops = {
    defaultSopsFile = "${self}/users/masa/sops/secrets.yaml";
    age.keyFile = "/home/masa/.config/sops/age/keys.txt";

    secrets = {
      "sing-box-uuid" = {
        owner = "masa";
        path = "/home/masa/.personal/sing-box/uuid";
        mode = "0400";
      };

      "sing-box-public-key" = {
        owner = "masa";
        path = "/home/masa/.personal/sing-box/public-key";
        mode = "0400";
      };

      "sing-box-short-id" = {
        owner = "masa";
        path = "/home/masa/.personal/sing-box/short-id";
        mode = "0400";
      };

      "github_token" = {
        owner = "masa";
        path = "/home/masa/.personal/github/token";
        mode = "0400";
      };
    };
  };
}
