from setuptools import setup
from labmesh import __version__

setup(
    name='labmesh',
    version=__version__,
    packages=[
        "labmesh",
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
