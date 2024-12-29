# A shell script "random", which actually runs function "main_func" from module "random", will be available after project installation.

# Random is the package name to be installed through pip

# random is the file name i.e. random.py with main_func clearly defined

from setuptools import setup, find_packages
setup(
    name = "Random",
    version = "0.1",
    packages = find_packages(),
    entry_points = {
        'console_scripts': [
            'rndm = rndm.rndm:main_func',  # Points to `main_func` in `rndm.py`
        ],
    }
)