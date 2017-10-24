all:
	@echo "req_install   - install requirements"
	@echo "req_upgrade   - update all requirements"
	@echo "run           - run server"

req_install:
	pip install pip-tools
	pip-sync

req_upgrade:
	pip-compile -U
	pip-sync

run:
	python app.py

