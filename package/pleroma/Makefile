all:
	echo "import Mix.Config" > config/prod.secret.exs
	mix local.hex --force
	mix local.rebar --force
	mix deps.get --only prod
	-mkdir release
	export CC=/home/kali/Documents/Development/fedbox/fedbox-external/output/host/bin/i586-buildroot-linux-musl-gcc; MIX_ENV=prod mix release --path release
