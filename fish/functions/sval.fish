function sval
	podman run --rm -v $(pwd):/app -w /app registry.code.roche.com/synergyplus/infrastructure/synergyplus-tools messaging-repo-validator
end

