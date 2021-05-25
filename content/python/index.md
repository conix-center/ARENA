---
title: Python Library
nav_order: 4
layout: default
has_children: true
---

# Python Library Overview
Draw objects and run programs in the ARENA using Python!
- [**ARENA-py**](https://github.com/conix-center/ARENA-py) Python repository


## Setup
Install package using pip:
```shell
pip3 install arena-py
```


## Hello ARENA
Run the `hello.py` example:
```shell
cd examples
python hello.py
```

`hello.py`
```python
from arena import *

scene = Scene(host="arenaxr.org", scene="example")

@scene.run_once
def make_box():
    scene.add_object(Box())

scene.run_tasks()
```

## ARENA-py Library
The above is the simplest example of an ARENA Python program. This library sits above the ARENA pub/sub MQTT
message protocol: JSON messages described in more detail [here](/content/messaging/definitions.html) which runs in a browser.
That forms a layer, in turn, on top of [A-Frame](https://aframe.io/) and [THREE.js](http://threejs.org/) javascript libraries.

## Examples
Examples of ARENA-py programs can be found [here](https://github.com/conix-center/ARENA-py/tree/master/examples) and [here](https://github.com/conix-center/ARENA-py/tree/master/system-tests).

## Running from the Command Line
The target of which server, user and scene are set by the `Scene(host="...",scene="...",namespace="...",debug=False)` function call.  It is also possible to override these using environmental variables at the command line as shown below.  This allows a simple way to re-target applications for your own environment without having to change the parameters manually in the code.
```shell
export MQTTH=arenaxr.org
export REALM=realm
export SCENE=scene
export NAMESPACE=namespace
python3 hello.py
...
=====
Loading: https://arenaxr.org/namespace/scene, realm=realm
Connecting to the ARENA...
Connected!
=====
...
```
If not specified the namespace is your current logged in user-id. The most common use-case is to simply update `SCENE` and `MQTTH`. `REALM` is currently reserved for future use, and will default to the string 'realm'.


## Authentication
We are adding protection to the ARENA MQTT broker, eventually to host an ACL list to limit access to change your scenes. As a first step, we are requiring Python programs to supply authentication through a Google account.

### Sign-In Desktop OS
If you have a web browser available, the ARENA-py library `Scene(host="myhost.com")` will launch a web browser the first time and ask you for an account to authenticate you with, before opening a client MQTT connection.

### Sign-In Server/Headless OS
For headless environments, the ARENA-py library `Scene(host="myhost.com")` will provide you with a url to cut and paste in a browser anywhere, ask you for an account to authenticate you with, and show you a code you can enter on the command line, before opening a client MQTT connection.

### Sign-Out
```bash
python3 -c "from arena import auth; auth.signout()"
```

### Show Permissions
```bash
python3 -c "from arena import auth; auth.permissions()"
```


## Python Interactive Robot Demo
<figure class="video_container">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/E7YkqZ5Hkas" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</figure>
