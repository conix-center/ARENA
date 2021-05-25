---
title: Examples
nav_order: 2
layout: default
parent: Messaging Format
---

# Messaging Format Examples

{% include alert type="warning" title="Warning" content="The code examples below are currently out of date and are being updated..." %}

- [**ARENA-core**](https://github.com/conix-center/ARENA-core) webserver repository

The structure of our MQTT messaging format is standardized into JSON. To run some of the commands below, you may need to install the Mosquitto client on your system: [https://mosquitto.org/](https://mosquitto.org/).

## Draw a Cube

Instantiate a cube and set all of it's basic parameters.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "create", "type": "object", "data": {"object_type": "cube", "position": {"x": 1, "y": 1, "z": -1}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 1, "y": 1, "z": 1}, "color": "#FF0000"}}'
```

## Color

Change only the color of the already-drawn cube.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": {"material": {"color": "#00FF00"}}}'
```

## Transparency

Say the cube has already been drawn. In a second command, this sets 50% transparency.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": {"material": {"transparent": true, "opacity": 0.5}}}'
```

## Move

Move the position of the already drawn cube.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": {"position": {"x": 2, "y": 2, "z": -1}}}'
```

## Rotate

Rotate the already drawn cube; these are in quaternions, not A-Frame degrees.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": {"rotation": {"x": 60, "y": 2, "z": 3}}}'
```

The quaternion (native) representation of rotation is a bit more tricky. The 4 parameters are X, Y, Z, W. Here are some simple examples:

- `1, 0, 0, 0`: rotate 180 degrees around X axis
- `0, 0.7, 0, 0.7`: rotate 90 degrees around Y axis
- `0, 0, -0.7, 0.7`: rotate -90 degrees around Z axis

## Animate

Animate rotation of the already drawn cube.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": { "animation": { "property": "rotation", "to": "0 360 0", "loop": true, "dur": 10000}} }'
```

Other animations are available that resemble the `"data": {"animation": { "property": ... }}` blob above: see [A-Frame Animation](https://aframe.io/docs/1.0.0/components/animation.html) documentation for more examples.

## Remove

Remove the cube.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "delete"}'
```

## Images

Create an image on the floor.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/image_floor -m '{"object_id": "image_floor", "action": "create", "data": {"object_type": "image", "position": {"x": 0, "y": 0, "z": 0.4}, "rotation": {"x": -0.7, "y": 0, "z": 0, "w": 0.7}, "url": "images/floor.png", "scale": {"x": 12, "y": 12, "z": 2}, "material": {"repeat": {"x": 4, "y": 4}}}}'
```

URLs work in the URL parameter slot. Instead of `images/2.png` it would be e.g. `url(http://arenaxr.org/images/foo.jpg)`.
To update the image of a named image already in the scene, use this syntax.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/image_2 -m '{"object_id": "image_2", "action": "update", "type": "object", "data": {"material": {"src": "https://arenaxr.org/abstract/downtown.png"}}}'
```

## Images on Objects

Use the `multisrc` A-Frame Component to specify different bitmaps for sides of a cube or other primitive shape.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/die1 -m '{"object_id": "die1", "action": "create", "type": "object", "data": {"object_type": "cube", "position": {"x": 0, "y": 0.5, "z": -2}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 1, "y": 1, "z": 1}, "color": "#ffffff", "dynamic-body": {"type": "dynamic"}, "multisrc": {"srcspath": "images/dice/", "srcs": "side1.png, side2.png, side3.png, side4.png, side5.png, side6.png"}}}'
```

## Other Primitives: TorusKnot

Instantiate a wacky torusKnot, then turn it blue. Other primitive types are available in the in [A-Frame docs](https://aframe.io/docs/1.0.0/components/geometry.html#built-in-geometries). Here is a brief list: **box circle cone cylinder dodecahedron icosahedron tetrahedron octahedron plane ring sphere torus torusKnot triangle**.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/torusKnot_1 -m '{"object_id": "torusKnot_1", "action": "create", "data": {"object_type": "torusKnot", "color": "red", "position": {"x": 0, "y": 1, "z": -4}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 1, "y": 1, "z": 1}}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/torusKnot_1 -m '{"object_id": "torusKnot_1", "action": "update", "type": "object", "data": {"material": {"color": "blue"}}}'
```

## Models

Instantiate a glTF v2.0 binary model (file extension .glb) from a URL.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_1 -m '{"object_id": "gltf-model_1", "action": "create", "data": {"object_type": "gltf-model", "url": "https://arenaxr.org/models/Duck.glb", "position": {"x": 0, "y": 1, "z": -4}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 1, "y": 1, "z": 1}}}'
```

## Animating GLTF Models

To animate a GLTF model (see [GLTF Files](../3d-content/gltf-files) for how to find animation names), and set the animation-mixer parameter.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_3 -m '{"object_id": "gltf-model_3", "action": "update", "type": "object", "data": {"animation-mixer": {"clip": "*"}}}'
```

The asterisk means "play all animations", and works better in some situations, where other times the name of a specific animation in the GLTF file works (or maybe several in sequence).

## Relocalize Camera Rig

Move the camera rig (parent object of the camera) with ID camera_1234567890_er1k to a new coordinate (system). Values are x, y, z, (meters) x, y, z, w (quaternions).

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/camera_1234567890_er1k -m '{"object_id": "camera_1234567890_er1k", "action": "update", "type": "rig", "data": {"position": {"x": 1, "y": 1, "z": 1}, "rotation": {"x": 0.1, "y": 0, "z": 0, "w": 1} }}'
```

This assumes we know our camera ID was assigned as `1234567890`. One way to find out your camera ID is, automatically assigned ones get printed on web browsers' Developer Tools Console in a message like `my-camera name camera_1234567890_X`. That might not be easily knowable without snooping MQTT messages, so the `&fixedCamera=er1k` URL parameter lets us choose manually the unique ID. If used in the URL, the `&name=` parameter is ignored, and the derived camera/user ID is based on fixedCamera, so would be in this case `camera_er1k_er1k`

## Move Camera

Move the camera with ID `camera_1234567890_er1k` to a new position. Values are x, y, z, (meters) x, y, z, w (quaternions). Action must be `update`.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/camera_1234567890_er1k -m '{"object_id":"camera_1234567890_er1k","action":"update","type":"camera-override","data":{"object_type":"camera","position":{"x":1.692,"y":1.6,"z":4.371},"rotation":{"x":0.003,"y":-0.003,"z":0,"w":1}}}'
```

This assumes we know our camera ID. One way to find out your camera ID is, automatically assigned ones get printed on web browsers' Developer Tools Console.

## Camera Look At

Make the camera with ID `camera_1234567890_er1k` look at an object or coordinate. Target can be given as x, y, z coordinate object (e.g. `{"x":1.692,"y":1.6,"z":4.371}`), or as a string with an object ID (e.g. `"cone_587431"`).  Action must be `update`.

```json

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/camera_1234567890_er1k -m '{"object_id":"camera_1234567890_er1k","action":"update","type":"camera-override","data":{"object_type":"look-at","target":"cone_587431"}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/camera_1234567890_er1k -m '{"object_id":"camera_1234567890_er1k","action":"update","type":"camera-override","data":{"object_type":"look-at","target":{"x": 0.467, "y": 2.066, "z": -1.027}}}'
```

This assumes we know our camera ID. One way to find out your camera ID is, automatically assigned ones get printed on web browsers' Developer Tools Console.

## Text

Add some red text that says "Hello World".

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/text_3 -m '{"object_id": "text_3", "action": "create", "data": {"color": "red", "text": "Hello world!", "object_type": "text", "position": {"x": 0, "y": 3, "z": -4}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 1, "y": 1, "z": 1}}}'
```

Change text color properties [A-Frame Text](https://aframe.io/docs/0.9.0/components/text.html#properties).

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/text_3 -m '{"object_id": "text_3", "action": "update", "type": "object", "data": {"text": {"color": "green"}}}'
```

## Lights

Create a red light in the scene.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/light_3 -m '{"object_id": "light_3", "action": "create", "data": {"object_type": "light", "position": {"x": 1, "y": 1, "z": 1}, "rotation": {"x": 0.25, "y": 0.25, "z": 0, "w": 1}, "color": "#FF0000"}}'
```

Default is ambient light. To change type, or other light [A-Frame Light](https://aframe.io/docs/0.9.0/components/light.html) parameters, example: change to **directional**. Options: **ambient, directional, hemisphere, point, spot**.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/light_3 -m '{"object_id": "light_3", "action": "update", "type": "object", "data": {"light": {"type": "directional"}}}'
```

## Sound

Play toy piano sound from a URL when you click a cube. Sets click-listener Component, waveform URL, and sound attribute.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box_asharp -m '{"object_id": "box_asharp", "action": "create", "data": {"object_type": "cube", "position": {"x": 2.5, "y": 0.25, "z": -5}, "scale": {"x": 0.8, "y": 1, "z": 1}, "color": "#000000", "sound": {"src": "url(https://arenaxr.org/audio/toypiano/Asharp1.wav)", "on": "mousedown"}, "click-listener": ""}}'
```

## 360 Video

Draw a sphere, set the texture src to be an equirectangular video, on the 'back' (inside).

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/sphere_vid -m '{"object_id": "sphere_vid", "action": "create", "type": "object", "data": {"object_type": "sphere", "scale": {"x": 200, "y": 200, "z": 200}, "rotation": {"x": 0, "y": 0.7, "z": 0, "w": 0.7}, "color": "#808080", "material": {"src": "images/360falls.mp4", "side": "back"}}}'
```

## Lines

Draw a purple line from (2, 2, 2) to (3, 3, 3).

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/line_1 -m '{"object_id": "line_1", "action": "create", "data": {"object_type": "line", "start": {"x": 2, "y": 2, "z": 2}, "end": {"x": 3, "y": 3, "z": 3}, "color": "#CE00FF"}}'
```

Extend the line with a new segment, colored green.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/line_1 -m '{"object_id": "line_1", "action": "update", "type": "object", "data": {"line__2": {"start": {"x": 3, "y": 3, "z": 3}, "end": {"x": 4, "y": 4, "z": 4}, "color": "#00FF00"}}}'
```

## Thicklines

A "thickline" (to improve openpose skeleton rendering visibility) - works like a line, but the `lineWidth` value specifies thickness, and multiple points can be specified at once, e.g. draw a pink line 11 pixels thick from 0, 0, 0 to 1, 0, 0 to 1, 1, 0 to 1, 1, 1. The shorthand syntax for coordinates is a bonus feature of lower level code; extending it for the rest of ARENA commands remains as an enhancement.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/thickline_8 -m '{"object_id": "thickline_8", "action": "create", "type": "object", "data": {"object_type": "thickline", "lineWidth": 11, "color": "#FF88EE", "path": "0 0 0, 1 0 0, 1 1 0, 1 1 1"}}'
```

You might be wondering, why can't normal lines just use the scale value to specify thickness? But this one goes to eleven! Really though, normal lines perform faster. To update a "thickline" takes a special syntax because thicklines are really "meshline"s.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/thickline_8 -m '{"object_id": "thickline_8", "action": "update", "type": "object", "data": {"meshline": {"lineWidth": 11, "color": "#FFFFFF", "path": "0 0 0, 0 0 1"}}}'
```

## Events

Add the "click-listener" event to a scene object; click-listener is a Component defined in `events.js`. This works for adding other, arbitrary Components. A non-empty message gets sent to the Component's `init: ` function.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id": "cube_1", "action": "update", "type": "object", "data": {"click-listener": "enable"}}'
```

## Persisted Objects

If we want our objects to return to the scene when we next open or reload our browser, we can commit them on creation to the ARENA Persistence DB by setting `"persist": true`.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/Ball2 -m '{"object_id": "Ball2", "action": "create", "persist": true, "data": {"position": {"x": -1, "y": 1, "z": -1}, "color": "blue", "object_type": "sphere"}}'
```

## Temporary Objects: TTL

It's desirable to have objects that don't last forever and pile up. For that there is the 'ttl' parameter that gives objects a lifetime, in seconds. This is an example usage for a sphere that disappears after 5 seconds.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/Ball2 -m '{"object_id": "Ball2", "action": "create", "ttl": 5, "data": {"position": {"x": -1, "y": 1, "z": -1}, "color": "blue", "object_type": "sphere"}}'
```

## Transparent Occlusion

To draw a shape that is transparent, but occludes other virtual objects behind it (to simulate virtual objects hidden by real world surfaces like a wall or table), include in the data section this JSON.

```json
{"material": {"colorWrite": false}, "render-order": "0"}
```

`colorWrite` is an attribute of the THREE.js Shader Material that, by exposing it, we make accessible like others belonging to the Material A-Frame Component, and is an alternative way of controlling visibility. `render-order` is a custom Component that controls which objects are drawn first (not necessarily the same as which are "in front of" others). All other ARENA objects are drawn with render-order of 1.

{% include alert type="note" title="Note" content="
This does not occlude the far background A-Frame layer (like environment component stars) but, in AR, that layer is not drawn anyway.
" %}

## Background Themes

Adds one of many predefined backgrounds ( one of: **none, default, contact, egypt, checkerboard, forest, goaland, yavapai, goldmine, threetowers, poison, arches, tron, japan, dream, volcano, starry, osiris**) to the scene

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/env -m '{"object_id": "env", "action": "update", "type": "object", "data": {"environment": {"preset": "arches"}}}'
```

## Physics

You can enable physics (gravity) for a scene object by adding the dynamic-body Component.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/box_3 -m '{"object_id": "box_3", "action": "update", "type": "object", "data": {"dynamic-body": {"type": "dynamic"}}}'
```

One physics feature is applying an impulse to an object to set it in motion. This happens in conjunction with an event. As an example, here are messages setting objects fallBox and fallBox2 to respond to `mouseup` and `mousedown` messages with an impulse with a certain force and position.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/fallBox2 '{"object_id": "fallBox2", "action": "create", "data": {"object_type": "cube", "dynamic-body": {"type": "dynamic"}, "impulse": {"on": "mousedown", "force": "1 50 1", "position": "1 1 1"}, "click-listener": "", "position": {"x": 0.1, "y": 4.5, "z": -4}, "scale": {"x": 0.5, "y": 0.5, "z": 0.5}}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/fallBox '{"object_id": "fallBox", "action": "create", "data": {"object_type": "cube", "dynamic-body": {"type": "dynamic"}, "impulse": {"on": "mouseup", "force": "1 50 1", "position": "1 1 1"}, "click-listener": "", "position": {"x": 0, "y": 4, "z": -4}, "scale": {"x": 0.5, "y": 0.5, "z": 0.5}}}'
```

## Parent/Child Linking

There is support to attach a child to an already-existing parent scene objects. When creating a child object, set the `"parent": "parent_object_id"` value in the JSON data. For example if parent object is gltf-model_Earth and child object is gltf-model_Moon, the commands would look like:

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Earth -m '{"object_id": "gltf-model_Earth", "action": "create", "data": {"object_type": "gltf-model", "position": {"x": 0, "y": 0.1, "z": 0}, "url": "models/Earth.glb", "scale": {"x": 5, "y": 5, "z": 5}}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/gltf-model_Moon -m '{"object_id": "gltf-model_Moon", "action": "create", "data": {"parent": "gltf-model_Earth", "object_type": "gltf-model", "position": {"x": 0, "y": 0.05, "z": 0.6}, "scale": {"x": 0.05, "y": 0.05, "z": 0.05}, "url": "models/Moon.glb" }}'
```

Child objects inherit attributes of their parent, for example scale. Scale the parent, the child scales with it. If the parent is already scaled, the child scale will be reflected right away. Child position values are relative to the parent and also scaled.

## Goto URL

Navigates to entirely new page into browser when clicked, or other event (requires `click-listener`).

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id" "cube_1", "action": "create", "type": "object", "data": {"object_type": "cube", "position": {"x": 1, "y": 1, "z": -1}, "click-listener": "", "goto-url": { "dest": "newtab", "on": "mousedown", "url": "http: www.eet.com"}}}'
```

## Particles

Particles are based on [aframe-spe-particles-component](https://github.com/harlyq/aframe-spe-particles-component), javascript loaded from [aframe-spe-particles-component.min.js](https://unpkg.com/aframe-spe-particles-component@^1.0.4/dist/aframe-spe-particles-component.min.js).

For now, it's not directly supported, but rather by passing JSON inside the `data{}` element. The syntax for parameter names has been updated so instead of a name like this that is `space-separated` it becomes `spaceSeparated` (camel case). Three examples here have been created starting with the examples in [aframe-spe-particles-component examples](https://harlyq.github.io/aframe-spe-particles-component/) then reformulating to ARENA JSON syntax.

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/smoke -m '{"object_id": "smoke", "action": "create", "data": {"object_type": "cube", "position": {"x": 0, "y": 1, "z": -3.9}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 0.01, "y": 0.01, "z": 0.01}, "color": "#ffffff", "spe-particles": {"texture": "textures/fog.png", "velocity": "1 30 0", "velocitySpread": "2 1 0.2", "particleCount": 50, "maxAge": 4, "size": "3, 8", "opacity": "0, 1, 0", "color": "#aaa, #222"}}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/flames -m '{"object_id": "flames", "action": "create", "data": {"object_type": "cube", "position": {"x": 0, "y": 1, "z": -3.8}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 0.01, "y": 0.01, "z": 0.01}, "color": "#ffffff", "spe-particles": {"texture": "textures/explosion_sheet.png", "textureFrames": "5 5", "velocity": "4 100 0", "acceleration": "0 10 0", "accelerationSpread": "0 10 0", "velocitySpread": "4 0 4", "particleCount": 15, "maxAge": 1, "size": "4, 8", "sizeSpread": 2, "opacity": "1, 0", "wiggle": "0 1 0", "blending": "additive"}}}'

python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/sparks -m '{"object_id": "sparks", "action": "create", "data": {"object_type": "cube", "position": {"x": 0, "y": 1, "z": -4}, "rotation": {"x": 0, "y": 0, "z": 0, "w": 1}, "scale": {"x": 0.01, "y": 0.01, "z": 0.01}, "color": "#ffffff", "spe-particles": {"texture": "textures/square.png", "color": "yellow, red", "particleCount": 3, "maxAge": 0.5, "maxAgeSpread": 1, "velocity": "40 200 40", "velocitySpread": "10 3 10", "wiggle": "50 0 50", "wiggleSpread": "15 0 15", "emitterScale": 8, "sizeSpread": 10, "randomizeVelocity": true}}}'
```

Particles are very complicated and take a lot of parameters. It would not make sense to translate all of them into explicit ARENA types, thus this flexible 'raw JSON' format is used.

## Events

Click events are generated as part of the laser-controls A-Frame entity; you get the events if you click the lasers on scene entities that have click-listener Component in their HTML declaration (see index.html), or have later had click-listener enabled via an MQTT message (see above). Mouse events occur if you click in a browser, or tap on a touchscreen as well.

* `mouseenter`
* `mouseleave`
* `mousedown`
* `mouseup`
- `triggerdown` / `triggerup` for left and right hand controllers

The MQTT topic name for viewing these events can be the standard prefix (e.g. realm/s/public/example/) concatenated with a string made up of object ID that generated the event. An example event MQTT:

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/fallBox2 '{"object_id": "fallBox2", "action": "clientEvent", "type": "mousedown", "data": {"position": {"x": -0.993, "y": 0.342, "z": -1.797}, "source": "camera_8715_er"}}'
```

{% include alert type="note" title="Note" content="
The message itself will contain the originator of the event as a camera/user ID and other data like where the object was clicked.
" %}

Full list of Vive controller event names:
  - `triggerdown`
  - `triggerup`
  - `gripdown`
  - `gripup`
  - `menudown`
  - `menuup`
  - `systemdown`
  - `systemup`
  - `trackpaddown`
  - `trackpadup`

## Scene Settings

Some settings are available by setting attributes of the Scene element (see [A-Frame Scene](https://aframe.io/docs/0.9.0/core/scene.html)) for example, turn on statistics:

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example -m '{"object_id": "scene", "action": "update", "type": "object", "data": {"stats": true}}'
```

Customize the fog (notice 3 character hexadecimal color representation):

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example -m '{"object_id": "scene", "action": "update", "type": "object", "data": {"fog": {"type": "linear", "color": "#F00"}}}'
```

Remove the "enter VR" icon:

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example -m '{"object_id": "scene", "action": "update", "type": "object", "data": {"vr-mode-ui": {"enabled": false}}}'
```
