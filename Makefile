run:
	nix-collect-garbage --delete-older-than 30d
	nix store optimise
	sudo nix run nix-darwin -- switch --flake .

lock:
	nix flake update


