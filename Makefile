install:
	pip install -r requirements.txt

install-dev: install
	pip install -r requirements-test.txt

lint:
	flake8 app tests

component:
	PYTHONPATH=./app pytest -sv tests/

coverage:
	PYTHONPATH=./app pytest tests/ --cov=app

test: lint component
