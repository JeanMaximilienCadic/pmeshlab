
<h1 align="center">
  <br>
  <br>
  pmeshlab
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
from pmeshlab import __version__

setup(
    name='pmeshlab',
    version=__version__,
    packages=[
        "pmeshlab",
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


```

### How to use
To clone and run this application, you'll need [Git](https://git-scm.com) and [ https://docs.docker.com/docker-for-mac/install/]( https://docs.docker.com/docker-for-mac/install/) and Python installed on your computer. 
From your command line:

Install pmeshlab:
```bash
# Clone this repository and install the code
git clone https://github.com/JeanMaximilienCadic/pmeshlab

# Go into the repository
cd pmeshlab
```

### PythonEnv (not recommended)
```
make install_wheels
```

### Docker
```shell
make build_docker
make docker_run_sandbox_cpu
```
