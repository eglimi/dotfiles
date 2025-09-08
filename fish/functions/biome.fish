function biome
	podman run --rm -it -v $(pwd):/app -w /app registry.code.roche.com/synergyplus/infrastructure/synergyplus-tools biome format --write /app/messages/ /app/shared_types/
end

