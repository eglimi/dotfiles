function skopeo
    if set -q argv[2]
        podman run --rm -v $XDG_RUNTIME_DIR/containers/auth.json:/tmp/auth.json:ro \
            quay.io/skopeo/stable:latest $argv[1] --authfile /tmp/auth.json $argv[2..-1]
    else
        podman run --rm -v $XDG_RUNTIME_DIR/containers/auth.json:/tmp/auth.json:ro \
            quay.io/skopeo/stable:latest $argv[1]
    end
end
