---
title: Develop Python Programs
nav_order: 4
layout: default
parent: Overview
---

# Introduction to ARENA Python Program Development

{% include alert type="note" content="
We recommend the [ARENA Overview](/content/overview) to learn the about the main concepts of the ARENA.
"%}

You can define the appearance and behavior of objects in a scene using python programs, which take advantage of the fact that all objects in a scene are networked via a MQTT Publish-Subscribe (PubSub) messaging bus:

<img src="/assets/img/overview/python-mqtt.png" width="500"/>

Note that the python program can be hosted anywhere with access to the MQTT bus. For simplicity, we will assume that your program is running on your local machine. However, the execution and hosting of programs can be handled by the ARENA itself, using ARTS.

[//]: # TODO: Link to ARTS.


## Install the ARENA Python library

The easiest way to begin programming in the ARENA is to install the [Python library](../python) and create your first Python program. ARENA programs communicate over MQTT messages which govern all objects and their properties. This library is a wrapper which will allow you to easily send and receive those messages.

{% include alert type="tip" content="
Use the **Search ARENA Documentation** bar at the very top of every page on this site to find examples and information on anything you need.
"%}

## Create a box and observe

Now, let us create a very simple Python program in the scene <b>example</b>, under the [username you defined the first time you entered the arena](/content/overview/user-guide.html#arena-username). Start by opening the scene in your browser and notice it is empty, with default environment settings.

{% include alert type="note" content="
Open the <b>example</b> scene under your arena username by entering the following URL in your browser: ```http://arenaxr.org/<your-username>/example```
"%}

Copy the python script below, and paste it into a ```box.py``` file. After saving the file, execute the script (e.g. ```python3 box.py```; make sure you installed the [python library](/content/python/) first).

```python
from arena import *

# this creates an object for scene 'example' at the given arena host
scene = Scene(host="arenaxr.org", scene="example")

# define a task that will add a box to the scene
@scene.run_once
def make_box():
    scene.add_object(Box())

# run the tasks defined for this scene
scene.run_tasks()
```

Looking at the scene in your browser will let you see the box. Watch out, if you are at the origin, the box will be underneath you.

![](../../../assets/img/overview/devguide/box.png)

By default, objects are generated in a random color, with no rotation, at x, y, z position (0, 0, 0), and with no other properties applied. Some of the other properties you can add to objects are detailed in our [Python Examples](../python/objects). Notice that the box seems stuck in the ground, which is due to the box's origin at its center positioned at scene coordinates (0, 0, 0). If you enable Flying mode (see [User Guide](user-guide)), you can move below the ground plane and view the other half of the box. Type Ctrl-C to end the program.

Now, go back to your browser and <b>refresh</b> the page. You will notice that the box disappeared. We will explain what is up with that in [a moment](#use-persistence-reload-browser). Now, let us create two boxes, one at x, y, z (1, 1, 1) and another at x, y, z (2, 2, 2).

```python
from arena import *

scene = Scene(host="arenaxr.org", scene="example")

@scene.run_once
def make_box():
    # red box at (1, 1, -3)
    box1 = Box(position=Position(1,1,-3), material=Material(color=(255,0,0)))
    scene.add_object(box1)
    # green box at (2, 2, -3)
    box2 = Box(position=Position(2,2,-3), material=Material(color=(0,255,0)))
    scene.add_object(box2)

scene.run_tasks()
```

Once you run the script above, you can go back to the scene <b>example</b> in your browser to see the two boxes:

![](../../../assets/img/overview/devguide/two-boxes.png)

## Running from the Command Line
The target of which server, user and scene are set by the `Scene(host="...",scene="...",namespace="...",debug=False)` function call.  It is also possible to override these using shell environmental variables at the command line as shown below.  This allows a simple way to re-target applications for your own environment without having to change the parameters manually in the code.
```shell
export MQTTH=arenaxr.org
export REALM=realm
export SCENE=scene
export NAMESPACE=namespace
python3 box.py
...
=====
Loading: https://arenaxr.org/namespace/scene, realm=realm
Connecting to the ARENA...
Connected!
=====
...
```
If not specified the namespace is your current logged in user-id. The most common use-case is to simply update `SCENE` and `MQTTH`. `REALM` is currently reserved for future use, and will default to the string 'realm'.


## Clients and Scene Callbacks

As a web browser user of the ARENA, you are connecting to the ARENA MQTT broker as one client connection, in which you are publishing your "camera" perspective as you move, and subscribing to changes in other objects and other users' "camera" moves. Every time you run a Python program you are also connecting to the broker as another client connection, in which the above program published a message creating a box, and also subscribes you other users "camera" moves, and objects.

Let's try observing some of those other messages but adding the following code to your Python program. Add the `scene_callback` function, and also alter your `arena.init()` call, to accept the new callback and allow you to observe all the messages you have subscribed to in this scene.

```python
def on_msg_callback(obj):
    print("scene_callback: ", obj)

scene.on_msg_callback = on_msg_callback
```

Move yourself around in the browser view and notice all the camera updates and positions and rotation changes as you move. This is way too much information to be human readable! However, you can filter out these messages for what you need, or even better, if you only need feedback for a specific object, like our box, as we cover next.

## Object callbacks

One way to reduce the flood of messages for your Python program is to define a callback specifically for one object, our box for example. Update your program to comment out all messages subscribed in the scene, add a callback just for your box object, and update the creation of your box object with a click-listener and the new `box_callback`.

```python
def on_msg_callback(obj):
#    print("scene_callback: ", obj)

def box_callback(evt):
    print("box_callback: ", evt)

box = Box(clickable=True, evt_handler=box_callback)
```

Now, in your scene use your mouse to click on the box and notice the messages you receive just from the box. You have useful information like: what type of event - mouse up/down/enter/leave, the owner of the event, the position of the owner, the position of the click. You can use this information to programmatically decide how to respond and begin creating a rich, interactive, 3d experience for your users.

- What should `mousedown` do for this object? Change its color?
- What should `mouseenter` or `mouseleave` do? Change its opacity?
- Many more ideas are available in our [examples](../python/events).

## Animate a GLTF model

A more advanced manipulation of objects in the ARENA is using 3d models as [GLTF](../3d-content/gltf-files). Here we are going to use a GLTF model of a duck and some animation rules to make it rotate.

```python
from arena import *

scene = Scene(host="arenaxr.org", scene="example")

obj = GLTF(object_id="duck_1",
            position=(-1, 1, -3),
            url="models/Duck.glb")
obj.dispatch_animation(
        Animation(
            property="rotation",
            start=(0,0,0),
            end=(0,180,0),
            easing="linear",
            dur=1000
        )
    )
scene.run_animations(obj)
scene.run_tasks()
```

At your leisure, read more about methods to generate [3d content](../3d-content) and [animate](../3d-content/animated-models) objects and models.

![](../../../assets/img/overview/animate.png)

## Use persistence, reload browser

Up until now, everything you have created has been non-persistent. That is, objects are only rendered in real-time for any browsers open to the `example` as MQTT messages are received. So, if you refresh your browser, notice that all the objects we created are gone, new visitors to this scene will not see them. To backup your scene objects into our [persistence database](../tools/persistence) you will have to specify `persist=True` in [Python definitions](../python/attributes). This is also true to when ARENA objects are created in other. The underlying message needs to specify if the object state is to be persisted or not.

Go back to the previous python code and try to add `persist=True` to the duck object:
```
obj = Model(object_id="duck_1",
            position=(-1, 1, -3),
            url="models/Duck.glb"
            persit=True)
```

If you run the program again, you will notice that the duck remains in the scene, even across a refresh.

## Debug your scene with A-Frame Scene Inspector
Since the ARENA's rendering uses the A-Frame web 3D rendering engine, you can open the [A-Frame Scene Inspector](https://aframe.io/docs/1.0.0/introduction/visual-inspector-and-dev-tools.html) on any scene to examine and manipulate any of the A-Frame elements in your scene.  Try this now from your example scene by typing `<ctrl> + <alt> + i` on most systems.

Examine the list of elements on the left side. Each element or object you select will show it's details and attributes on the right side. You may edit any attributes here you wish, however, remember that the A-Frame Scene Inspector will not persist any changes to the persistence database. We do have a way to visually manipulate objects and save changes that we will share next.

![](../../../assets/img/overview/inspector.png)

## AR Builder, visual content authoring
We also have a Python program, [AR Builder (ARB)](../tools/authoring), which you can use to create and edit objects for your scene. You can use it in VR (virtual reality) as a way to edit your scene and save changes to the persistence database. Importantly, you can use it in AR (augmented reality) in combination with [AR-supported browsers](https://createwebxr.com/webAR.html) and [localization techniques](../localization) to anchor scene objects in physical space.

{% include alert type="note" title="note" content="
AR-supported browsers still need customization from our lab to support visual localization tags.
" %}

In either case, ARB allows any user in the scene to edit, so it can be used collaboratively by multiple users remotely as VR, in person as AR, or as XR (mixed reality), a combination of both.

<figure class="video_container">
  <iframe width="560" height="315" src="https://www.youtube.com/embed/bYantKzkTFk" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</figure>
