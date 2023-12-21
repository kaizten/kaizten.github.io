# Production Planning 

<!-- TOC -->

- [:notebook\_with\_decorative\_cover: Description](#notebook_with_decorative_cover-description)
- [:hammer\_and\_wrench: Components](#hammer_and_wrench-components)
- [:gear: How to use](#gear-how-to-use)

<!-- /TOC -->

## :notebook_with_decorative_cover: Description

This docker compose is aimed at solving the Production Planning Problem. It is an optimization problem where there is a set of production lines dedicated to do working orders.

## :hammer_and_wrench: Components

The docker-compose is composed of the following components:

* `kaizten-task-lite (8080)`. Component that allows the execution of the algorithm.
* `production-planning-problem-vizualizer (80)`. A front-end to execute the optimization techniques and show the solutions reported by them.
* `watchtower`. A process for automating Docker container base image updates.

## :gear: How to use

> :warning: In order to execute the components by means of [Docker compose](https://docs.docker.com/compose/), the [Docker images](https://en.wikipedia.org/wiki/Docker_(software)) must be firstly available. This [Docker images](https://en.wikipedia.org/wiki/Docker_(software)) are publicly available.

The tool can be run by means of [Docker compose](https://docs.docker.com/compose/) as follows:
```shell
$ URL=http://172.31.238.156 docker compose up
```

It is important to note that the environment variable `URL` refers to the hostname of the machine on which the docker-compose is running, with the default being `http://localhost`, but it can be specified through the `URL` environment variable.

