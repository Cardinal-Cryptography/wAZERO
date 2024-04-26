.PHONY: build
build:
	@docker run --rm \
		--name ink-dev \
		--volume "$(shell pwd)":/code \
		public.ecr.aws/p6e8q1z1/ink-dev:2.1.0 \
		cargo contract build --release

.PHONY: test
test:
	@docker run --rm \
		--name ink-dev \
		--volume "$(shell pwd)":/code \
		public.ecr.aws/p6e8q1z1/ink-dev:2.1.0 \
		cargo test