include .env
export

setup-local:
	docker compose up -d

migrate-create:
	docker compose run --rm postgres-migrate \
		create -ext sql -dir /migrations -seq "$(name)"

migrate-up:
	docker compose run --rm postgres-migrate \
		-path /migrations -database "postgres://$(DB_USER):$(DB_PASSWORD)@postgres:5432/$(DB_DATABASE)?sslmode=disable" up

migrate-down:
	docker compose run --rm postgres-migrate \
		-path /migrations -database "postgres://$(DB_USER):$(DB_PASSWORD)@postgres:5432/$(DB_DATABASE)?sslmode=disable" down 1

migrate-force:
	docker compose run --rm postgres-migrate \
		-path /migrations -database "postgres://$(DB_USER):$(DB_PASSWORD)@postgres:5432/$(DB_DATABASE)?sslmode=disable" force $(version)