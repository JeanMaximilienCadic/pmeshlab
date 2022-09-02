from setuptools import setup
from PyMeshLab import __version__

setup(
    name='PyMeshLab',
    version=__version__,
    packages=[
        "PyMeshLab",
    ],
    license='MIT',
    author='Jean Maximilien Cadic',
    python_requires='>=3.6',
    install_requires=[r.rsplit()[0] for r in open("requirements.txt")],
    description='3D Mesh processing',
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
    ]
)
