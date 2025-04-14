{lib, config, ...}:
{

	options.emacsLib = {
		makeSymlink = lib.mkOption{
			default = Path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixconfig/config/users/homemanager/emacs/${Path}";
			};
	};
}
