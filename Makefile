run:
	sudo nix run nix-darwin -- switch --flake .

clean:
	nix-collect-garbage --delete-older-than 30d
	nix store optimise

lock:
	nix flake update


