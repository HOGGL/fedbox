all:
	echo "import Mix.Config" > config/prod.secret.exs
	mix local.hex --force
	mix local.rebar --force
	mix deps.get --only prod
	-mkdir release
	MIX_ENV=prod mix release --path release
