# A shell script "rndm", which actually runs function "main_func" from module "rndm.py", will be available after project installation.

# Random is the package name to be installed through pip

# rndm on left side defines what you want your custom function call to be
# right side defines that main file is in a directory called rndm. which should contain rndm.py and an __init__.py so that 
# compiler knows this is a custom package 

# __init__.py can be empty as well but it must exist

# this file setup.py must not exist in the same directory as rndm.py
# however it must be directly visible under the main code directory

# from setuptools import setup, find_packages
# setup(
#     name = "Random",
#     version = "0.1",
#     packages = find_packages(),
#     entry_points = {
#         'console_scripts': [
#             'rndm greet = rndm.rndm:greeting',  # Points to `main_func` in `rndm.py`
#             'rndm = rndm.rndm:main_func',
#         ],
#     }
# )

from setuptools import setup, find_packages

setup(
    name="Random",
    version="0.1",
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'rndm = rndm.rndm:main_func',  # Main entry point
        ],
    },
)