.PHONY: docs release clean build

clean:
	rm -rf protlibtcpserver_env htmlcov

build:
	virtualenv -p /usr/local/bin/python protlibtcpserver_env && source protlibtcpserver_env/bin/activate && \
		pip install -r requirements.txt

test: clean build
		source protlibtcpserver_env/bin/activate && \
		coverage run --source=protlibtcpserver setup.py test && \
		coverage html && \
		coverage report

docs:
	sphinx-build -aE docs build/docs > /dev/null

release: test docs
	open docs/generated/index.html
	open htmlcov/index.html
	vim protlibtcpserver/__init__.py