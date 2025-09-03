{...}:
{

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Steam Remote Play
  dedicatedServer.openFirewall = true; # Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Steam Local Network Game Transfers
};


}
