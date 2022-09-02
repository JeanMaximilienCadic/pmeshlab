
<h1 align="center">
  <br>
  <a href="https://drive.google.com/uc?id=1HAHHuAKoeIJ2NSkQQvLwIMS42Y19a3Bf"><img src="https://drive.google.com/uc?id=1HAHHuAKoeIJ2NSkQQvLwIMS42Y19a3Bf" alt="IDGraph" width="200"></a>
  <br>
  KironMesh
  <br>
</h1>

<p align="center">
  <a href="#code-structure">Code</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#docker">Docker</a> •
  <a href="#PythonEnv">PythonEnv</a> •
  <a href="#Databricks">Databricks</a> •

[comment]: <> (  <a href="#notebook">Notebook </a> •)
</p>


### Code structure
```python
from setuptools import setup
from kironmesh import __version__
setup(
    name='kironmesh',
    version=__version__,
    packages=[
        "kironmesh",
    ],
    url='https://github.com/Kironics/kironmesh',
    license='Kironics',
    author='Jean Maximilien Cadic, Alessandro Faedda',
    python_requires='>=3.9',
    install_requires=[r.rsplit()[0] for r in open("requirements.txt")],
    description='3D Mesh processing',
    classifiers=[
        "Programming Language :: Python :: 3.9",
        "License :: OSI Approved :: MIT License",
    ]
)
```

### How to use
To clone and run this application, you'll need [Git](https://git-scm.com) and [ https://docs.docker.com/docker-for-mac/install/]( https://docs.docker.com/docker-for-mac/install/) and Python installed on your computer. 
From your command line:

Install kironmesh:
```bash
# Clone this repository and install the code
git clone https://github.com/Kironics/kironmesh

# Go into the repository
cd kironmesh
```


### Docker
```shell
pip install dist/*.whl && cd scripts && ./run
```

### PythonEnv
```
pip install dist/*.whl
```
