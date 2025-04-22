# Dependencies

- `cargo add wasm-bindgen`
- `rustup target add wasm32-unknown-unknown`


# Build wasm
- `cargo build --target wasm32-unknown-unknown --release`

# Build bundled javascript
- `cargo install wasm-bindgen-cli`
- `wasm-bindgen target/wasm32-unknown-unknown/release/lib_wasm.wasm --target web --out-dir ./example/public`