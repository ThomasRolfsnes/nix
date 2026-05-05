run:
	sudo darwin-rebuild switch --flake .

clean:
	nix-collect-garbage --delete-older-than 30d
	nix store optimise

lock:
	nix flake update


