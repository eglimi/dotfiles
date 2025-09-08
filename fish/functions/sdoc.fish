function sdoc
	podman run --rm -v $(pwd):/app -w /app registry.code.roche.com/synergyplus/infrastructure/synergyplus-tools doc-generator --input ./messages --output ./docs
end
