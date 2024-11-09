.PHONY: setup lint lint-fix test

setup:
	@echo "Installing dependencies..."
	@bundle install

lint:
	@echo "Running RuboCop..."
	@bundle exec rubocop

lint-fix:
	@echo "Running RuboCop auto-correct..."
	@bundle exec rubocop -a

test:
	@echo "Running tests..."
	@bundle exec rspec

ci: setup lint test
	@echo "CI pipeline completed successfully!"

.DEFAULT_GOAL := setup