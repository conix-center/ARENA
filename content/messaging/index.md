---
title: Messaging Format
nav_order: 3
layout: default
has_children: true
---

# Messaging Format Overview

{% include alert type="warning" title="Warning" content="The code examples below are currently out of date and are being updated..." %}

Render 3d content in AFrame from MQTT messages
- [**ARENA-core**](https://github.com/conix-center/ARENA-core) webserver repository

## General Purpose AFrame using Subtopics
Most of ARENA's MQTT messages take JSON data where x,y,z (location in meters), x,y,z,w (rotation in quaternions), x,y,z (scale factor where 1=100%).
If you leave out any of these, defaults will be used: location(0,0,0), rotation(0,0,0,1), scale(1,1,1), color(white). Another general setting is whether or not to persist an object to the ARENA scene database, determined by `"persist": true`.

![ARENA JSON Format](../../assets/img/messaging/arena-obj.png)

## Sample scene: Earth and Moon with Markers
MQTT messages that define the scene:

### Create models
```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Earth -m '{"object_id": "gltf-model_Earth", "action": "create", "data": {"object_type": "gltf-model", "position": {"x":0, "y": 0.1, "z": 0}, "url": "models/Earth.glb", "scale": {"x": 5, "y": 5, "z": 5}}}'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Moon -m '{"object_id": "gltf-model_Moon", "action": "create", "data": {"parent": "gltf-model_Earth", "object_type": "gltf-model", "position": {"x":0, "y": 0.05, "z": 0.6}, "scale": {"x":0.05, "y": 0.05, "z": 0.05}, "url": "models/Moon.glb" }}'
```
### Define animation and movement
 ```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Earth -m '{"object_id" : "gltf-model_Earth", "action": "update", "type": "object", "data": {"animation": { "property": "rotation", "to": "0 360 0", "loop": true, "dur": 20000, "easing": "linear"}} }'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Earth -m '{"object_id" : "gltf-model_Earth", "action": "update", "type": "object", "data": {"startEvents": "click", "property": "scale", "dur": 1000, "from": "10 10 10", "to": "5 5 5", "easing": "easeInOutCirc", "loop": 5, "dir": "alternate"} }'
```
### Add a click-listener
```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Earth -m '{"object_id" : "gltf-model_Earth", "action": "update", "type": "object", "data": {"click-listener": ""}}'
```
### Create marker objects
```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box0 -m '{"object_id" : "box0", "action": "create", "data": {"color": "blue", "object_type": "cube", "scale":  {"x": 0.2, "y": 0.2, "z": 0.2}, "position": {"x": 0, "y": 0, "z": 0} }}'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box1 -m '{"object_id" : "box1", "action": "create", "data": {"color": "red", "object_type": "cube", "scale":  {"x": 0.2, "y": 0.2, "z": 0.2}, "position": {"x": -0.7, "y": 1.67, "z": 2.11} }}'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box2 -m '{"object_id" : "box2", "action": "create", "data": {"color": "red", "object_type": "cube", "scale":  {"x": 0.2, "y": 0.2, "z": 0.2}, "position": {"x": -2.88, "y": 2.80, "z": -2.12} }}'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box3 -m '{"object_id" : "box3", "action": "create", "data": {"color": "red", "object_type": "cube", "scale":  {"x": 0.2, "y": 0.2, "z": 0.2}, "position": {"x": -0.09, "y": 1.30, "z": -3.66} }}'
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box4 -m '{"object_id" : "box4", "action": "create", "data": {"color": "red", "object_type": "cube", "scale":  {"x": 0.2, "y": 0.2, "z": 0.2}, "position": {"x": 3.31, "y": 2.00, "z": -0.97} }}'
```
### Results
{% include alert type="warning" title="TODO" content="Include awesome demo result from design doc." %}
