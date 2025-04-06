return {
  cmd = { 'rust-analyzer' },
  root_markers = { 'Cargo.toml', 'compile_flags.txt' },
  filetypes = { 'rust' },
  settings = {
    ['rust-analyzer'] = {
      completion = { limit = nil, }
    }
  }
}
