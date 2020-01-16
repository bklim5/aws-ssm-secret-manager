install:
	pip install -r requirements.txt

install-dev: install
	pip install -r requirements-test.txt

lint:
	flake8 secret_manager tests

component:
	PYTHONPATH=./secret_manager:. pytest -sv tests/

coverage:
	PYTHONPATH=./secret_manager:. pytest tests/ --cov=secret_manager

test: lint component

cleanup-build:
	rm -rf ./build
	rm -rf ./dist
	python setup.py sdist bdist_wheel

pypi-dev: cleanup-build
	python -m twine upload --repository-url https://test.pypi.org/legacy/ dist/*

pypi: cleanup-build
	python -m twine upload dist/*