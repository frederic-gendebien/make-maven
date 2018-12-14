NAME=make-maven
VERSION=0.1.0
LATEST_TAG=$(NAME):latest
VERSION_TAG=$(NAME):$(VERSION)
REPOSITORY=fredericgendebien/

clean:
	-docker rmi --force \
		$(VERSION_TAG) \
		$(LATEST_TAG) \
		$(REPOSITORY)$(VERSION_TAG) \
		$(REPOSITORY)$(LATEST_TAG)

build:
	docker build --no-cache . \
		-t $(VERSION_TAG) \
		-t $(LATEST_TAG) \
		-t $(REPOSITORY)$(VERSION_TAG) \
		-t $(REPOSITORY)$(LATEST_TAG)

push:
	docker push $(REPOSITORY)$(VERSION_TAG)
	docker push $(REPOSITORY)$(LATEST_TAG)

shell:
	docker run -ti $(NAME) /bin/sh

new-feature:
	@read -p "Feature Name: " name; \
	git flow feature start --fetch --showcommands $$name
	@echo git flow feature finish > .finish

new-bugfix:
	@read -p "Bugfix Name: " name; \
	git flow bugfix start --fetch --showcommands $$name
	@echo git flow bugfix finish > .finish

new-release:
	@read -p "Release Version: " version; \
	git flow release start -F --showcommands $$version
	@echo git flow release finish > .finish

new-hotfix:
	@read -p "Hotfix Version: " version; \
	git flow hotfix start -F --showcommands $$version
	@echo git flow hotfix finish > .finish

new-support:
	@read -p "Support Version: " version; \
	git flow support start -F --showcommands $$version

finish:
	@`cat .finish`
