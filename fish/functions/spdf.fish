function spdf
	podman run --rm -v $(pwd):/app -w /app registry.code.roche.com/synergyplus/infrastructure/synergyplus-tools sh -c "pandoc --file-scope \$(doc-order --summary docs/SUMMARY.md --input docs) --from=markdown+rebase_relative_paths --filter pandoc-plantuml --metadata=plantuml-format=svg --pdf-engine=typst -V title=\"Local doc\" -o out.pdf"
end

