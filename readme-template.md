<p align="center"><img align="center" width="280" src=".github/Howest-logo-wit.svg#gh-dark-mode-only"/></p>
<p align="center"><img align="center" width="280" src=".github/Howest-logo-zwart.svg#gh-light-mode-only"/></p>

<h3 align="center">One-liner about your project goes here ✨</h3>

<hr>

_Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur._

## Table of contents :page_facing_up:

- [Built with](#built-with-toolbox)
- [Project setup](#project-setup-hammer_and_wrench)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Deployment](#deployment-rocket)
  - [Prerequisites](#prerequisites-1)
  - [Deployment](#deployment)
- [Future improvements](#future-improvements-bulb)
- [Possible issues](#possible-issues-x)

## Built with :toolbox:

## Project setup :hammer_and_wrench:

### Prerequisites

It is highly recommended to open this project inside a **Devcontainer\***. <br>
If you are developing locally instead, you will need Python on your host system. <br>

It is recommended to use **Poetry\*** instead of **venv**. <br>
If you are using venv anyway, you can set up the environment with the following commands:

```sh
python -m venv .venv

source .venv/bin/activate   # <-- Linux/MacOS
.venv\Scripts\activate      # <-- Windows
```

<details>

<summary>* More information about Devcontainers</summary>

A **Devcontainer** is a containerized development environment that can be used with Visual Studio Code.
It ensures that everyone in the team not only has the same dependencies installed, but also the same OS, tools, settings, VSCode extensions, ...
It uses Docker under the hood and can be configured using a `devcontainer.json` file inside the `.devcontainer` directory.

To use a Devcontainer, you need to have **Docker** and **Visual Studio Code** installed on your host system.
Follow the instructions in the [Devcontainer README](.devcontainer/Readme.md) to set up the environment.

</details>

<details>

<summary>* More information about Poetry</summary>

Poetry is a venv-like solution with great dependency management. <br>
It uses a `pyproject.toml` file rather than a `requirements.txt` file. <br>
With venv, you need to manually add packages to `requirements.txt` after every `pip install`. <br>
Poetry automatically updates `pyproject.toml` after every `poetry add`. <br>

|                               | Venv                                                         | Poetry                 |
| :---------------------------- | :----------------------------------------------------------- | :--------------------- |
| **Create environment**        | `python -m venv .venv`                                       | `poetry init`          |
| **Activate environment**      | `source .venv/bin/activate` or <br> `.venv\Scripts\activate` | `poetry shell`         |
| **Install single dependency** | `pip install <package>`                                      | `poetry add <package>` |
| **Install all dependencies**  | `pip install -r requirements.txt`                            | `poetry install`       |

To install Poetry, run the following commands:

```sh
pip install poetry

# Confirm the installation was successful
poetry --version
```

</details>

### Installation

1. Install the required dependencies

   ```sh
   pip install -r requirements.txt
   ```

2. Create a `.env` file in the root of the project

   ```env
   SECRET_KEY=your_secret_key
   ```

3. Run the project locally

   ```sh
   python main.py
   ```

4. Open your browser and go to [http://localhost:5000](http://localhost:5000)

## Deployment :rocket:

### Prerequisites

To deploy this project you will need **Docker** with **Docker Compose**.

### Deployment

1. Create a new repository on Docker Hub

2. Execute the following commands in the terminal

   ```sh
   docker login
   docker build -t project_name:version .
   docker tag project_name:version your_docker_username/your_repository_name:version
   docker push your_docker_username/your_repository_name:version
   ```

## Future improvements :bulb:

- [ ] Improve the design
- [ ] Add more features
- [ ] Add more tests
- [ ] Add more documentation

## Possible issues :x:

| Issue                                        | Solution                                                                                                  |
| :------------------------------------------- | :-------------------------------------------------------------------------------------------------------- |
| Any problem regarding Devcontainers.         | Check the [Devcontainer README](.devcontainer/Readme.md) file.                                            |
| Poetry environment not showing up in VSCode. | Reload your VSCode window. If the problem persists, run `poetry init && poetry install` and reload again. |