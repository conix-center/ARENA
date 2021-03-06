---
title: Build Scenes
nav_order: 3
layout: default
parent: Overview
---

# Build an ARENA Scene

{% include alert type="note" content="
We recommend the [ARENA Overview](/content/overview) to learn the about the main concepts of the ARENA.
"%}

We will now do a quick tour of a simple interface to edit ARENA scenes. We will see how to create a scene and add some content to it.

## Add a Scene

Head to the [build page (in a new tab)](https://arenaxr.org/build){:target="\_blank"}. If you never created a scene, it will look similar to this:

![](/assets/img/overview/build/build-empty.png)

{% include alert type="note" content="
You might need to sign-in to use the build webpage. The `conix` in the upper right corner and in the **User or Organization** select is the username we used to login for this demo. Your username should appear there.
"%}

As indicated in the *Scenes* select, your user has no scenes. Let us add one by pressing the <button type="button" name="button" class="btn fs-3 ">**+**</button> button (highlighted with a circle in the figure above). This will pop a dialog to create the new scene as follows.

<img src="/assets/img/overview/build/new-scene.png" width="400"/>

It is likely that you only have access to your User/Organization, so the first select will have only your username. Enter the name of the scene in the *Scene* input. You also have the choice to start your scene with some objects copied from the `public/default` scene. It is a good idea to do this, so let us leave it checked.

Once you are done, press the <button type="button" name="button" class="btn btn-blue fs-3">Add Scene</button> button, which will prompt a '**Create** Object create published' popup message in the corner. The popup will disappear in a second. Let us take this time to have a look at a few other sections of the build page shown below.

![](/assets/img/overview/build/build-sections.png)

{% include alert type="note" content="
Because we let the '*Add Objects From Default Scene*' option checked when creating the scene, it has an objects already: a `scene options` object. We will play with this in a bit.
"%}

In the figure above, we numbered (orange boxes) the following sections of the page:
1.  **Scene selection**: Select the scene you are editing here. As we have seen, we can also add scenes. Additionally, we can delete a scene and force a refresh of the scene list.
  - 1.a. This area has a logout button, and a button that allows you to check your permissions.
1.  **Scene Objects**: See a list of the objects **persisted** in the scene. At the bottom of the list there are buttons to delete, copy and select objects. To select a single object, click on its name (the line will become darker). You can press the object's edit button <button type="button" name="button" class="btn fs-3 "><img src="/assets/img/overview/build/icon-edit.png" width="20"/></button> (highlighted with a circle in the figure above) to edit its properties.
  - 2.a. This area lets you filter the objects in the object list. Click on the list to toggle show/hide of object types.
1.  **Add/Edit Object**: This section allows editing the properties of a new or an existing object (by pressing the edit <button type="button" name="button" class="btn fs-3 "><img src="/assets/img/overview/build/icon-edit.png" width="20"/></button> button in the object list).

Let us see the **Scene Objects** and **Add/Edit Objects** sections in a little more detail now.

## Edit Object Properties

Notice that, because we let the '*Add Objects From Default Scene*' option checked when creating the scene, the scene list is now populated. If you did not check the option (or your setup does not have objects in the `public/default` scene), don't worry; come back to this section later, after you know how to add a `scene options` object to the scene.

Press the edit <button type="button" name="button" class="btn fs-3 "><img src="/assets/img/overview/build/icon-edit.png" width="20"/></button> button of the `scene options` object (if it appears in your list):

|![](/assets/img/overview/build/objects-list.png)| ![](/assets/img/overview/build/edit-popup.png)|

This will trigger a popup in the upper left corner indicating that the object properties were loaded into the form show in the **Add/Edit Object** section (the popup will disappear in a few seconds).

You can now edit the object properties. When we are done editing the object, we can press the <button type="button" name="button" class="btn btn-blue fs-3">**+** Add/Update Object</button> button to trigger an update.

Below you have an example of how the entire **Add/Edit Object** section might look like after loading the `scene options` object. The **Type** select shows the type of the object being displayed. The ARENA has many object types as you can observe by opening the select. Most of the object types are 3D Objects, such as spheres, boxes, or GLTF models. There are also a few other object types to, for example, configure scenes (`scene options`) and to add programs to scene.

Under the **Type** select you have some buttons to <button type="button" name="button" class="btn fs-3">Clear form</button> (for example, if you want to add a new object), to create an object identifier <button type="button" name="button" class="btn fs-3">Gen object_id</button> (some objects, such as programs, require long, unique identifiers), and the <button type="button" name="button" class="btn btn-blue fs-3">**+** Add/Update Object</button> button to trigger an update of the object.

Notice the **Object JSON** on the right, this is a text representation of the object being edited in the form. All object in the ARENA have a [JSON](https://www.json.org/json-en.html) representation. As you edit the form, the JSON will be updated. You can also edit the JSON directly and use the <button type="button" name="button" class="btn fs-3">Update form</button> to reflect those edits back to the form. The **Validation** below will output any validation error detected in the object.

Have a look at the form. We will look closer at the sections within the form below, which are mainly defined by the object type (in this case, `scene options`).

![](/assets/img/overview/build/add-edit-form.png)

The first 4 properties of the form (**object_id**, **action**, **persist**, **type**) are common to all ARENA objects.

{% include alert type="warning" content="
Note that the **persit** property defines if the object state is to be persisted, or not. In case `persist=false`, the object will **not** be added to the object list (**Scene Objects** section). The update (triggered by the **Add/Update Object** button) will only be seen by current observers of the scene, will be lost once they leave or reload and will not be seen by observers joining the scene after the update.
"%}

A `scene options` object allows to set options for a [preset environment in the scene](https://github.com/supermedium/aframe-environment-component), set some scene options (such as audio range, publish behavior, or scene privacy) and define some renderer settings. The properties that appear on the form (and, therefore, the options that are available to be configured with the object) can be set with the <button type="button" name="button" class="btn fs-3">Properties</button> button. Notice the 3 different sections of the `scene options` object:

<img src="/assets/img/overview/build/scene-options-obj.png" width="500"/>

The checkboxes allow to hide/show those sub-sections (in reality, these are objects themselves) of the top-level object (`scene options`). Notice that each sub-section has it's own <button type="button" name="button" class="btn fs-3">Properties</button> button. For example, the environment presets:

<img src="/assets/img/overview/build/env-presets.png" width="500"/>

{% include alert type="tip" content="
**Feel free to add properties and set their values to see their effect in the scene.**
"%}

Later, we will add a nice model to our scene. To prepare the scene for it, try to set the environment preset to `forest`, add a point light to the scene at 0, 5, 0 (x, y, z), and set shadows to `true`:

<img src="/assets/img/overview/build/env-presets-example.png" width="500"/>

{% include alert type="note" content="
The order of the fields might be different for you (depending on the order you added them).
"%}

After making the edits, update the object by pressing the <button type="button" name="button" class="btn btn-blue fs-3">**+** Add/Update Object</button> button. You will have to reload the scene to have the new `scene options` applied.

{% include alert type="warning" content="
Contrary to most objects in the ARENA, most `scene options` require a scene reload to take effect.
"%}

## Add new Objects

Let us try to add a new object to our scene. We will add a GLTF model of the [Mammuthus primigenius (Blumbach)](https://3d.si.edu/object/3d/mammuthus-primigenius-blumbach:341c96cd-f967-4540-8ed1-d3fc56d31f12). In order to use it in the ARENA, we uploaded a .glb copy to dropbox and shared it publicly: [https://www.dropbox.com/s/pgytn552kzukm8f/blumbach.glb?dl=0](https://www.dropbox.com/s/pgytn552kzukm8f/blumbach.glb?dl=0).

{% include alert type="note" content="
**Why Dropbox?** ARENA internally converts dropbox **share** links into `dl.dropboxusercontent.com`, which currently allows the ARENA to use the content hosted at dropbox due to [Cross-origin Resource Sharing](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing).
"%}

{% include alert type="warning" content="
When using downloaded models, please make sure that the [author is properly credited](/content/3d-content/gltf-files.html#gltf-attribution).
"%}

Start by selecting the GLFT model object type from the *Type* select at the top of the **Add/Edit Object** section:

<img src="/assets/img/overview/build/gltf-model-obj.png" width="500"/>

As you select the GLTF model, the form will change to the default properties for this object type. Let us edit the form and enter:
1. **object_id**: `blumbach` (any name that identifies the model will do)
1. **action**: `create` (creating the object)
1. **persist**: `true` (want to persist)
1. **Url**: `https://www.dropbox.com/s/pgytn552kzukm8f/blumbach.glb?dl=0` (the dropbox **share** link)
1. **Position**: 0, 1.7, -5, (x, y, z)
1. **Rotation**: 0, 45, 0, (x, y, z)
1. **Scale**: 1, 1, 1, (x, y, z)

In order to have nice shadows from our model, add a `shadow` property to the GLTF model:

<img src="/assets/img/overview/build/shadow-property.png" width="500"/>

And enable both cast and receive shadows:

<img src="/assets/img/overview/build/shadow-enable.png" width="500"/>

Update the object by pressing the <button type="button" name="button" class="btn btn-blue fs-3">**+** Add/Update Object</button> button. Now, if you open the scene in your browser by following the link at the top of the page:

<img src="/assets/img/overview/build/open-scene-link.png" width="300"/>

You should have a magnificent Mammuthus primigenius (Blumbach) in your scene!

![](/assets/img/overview/build/mammuthus-primigenius-scene.png)

{% include alert type="tip" content="
**Other object types (3D objects, scene options, landmarks) can be added in a similar way.**
"%}

### Add Landmarks

A list of Landmarks is shown from the button at the bottom left corner of the screen
[ <img src="/assets/img/overview/build/landmarks.svg" width="20"/> ](#){: .btn .mr-4}.

Landmarks allow to jump to certain places on interest in a scene. If you copied the landmarks from `scene/public`, it is likely that you have a single landmark pointing to a *Screenshare*:

<img src="/assets/img/overview/build/landmark-list.png" width="300"/>

Let us add a landmark to Mammuthus primigenius (Blumbach) model. This way, wherever we are in the scene, we can quickly jump to be near it. Start by selecting existing the Mammuthus object from the list.

Update the object by pressing the <button type="button" name="button" class="btn btn-blue fs-3">**+** Add/Update Object</button> button. 

Under the **GLTF Model Data** section, click on the <button type="button" name="button" class="btn btn-blue fs-3">Properties</button>, and check/add
the [`Landmark` property](../messaging/definitions#landmark-object). Add the `label` "Mammuthus primigenius (Blumbach)".

![](/assets/img/overview/build/landmarks-obj.png)

The landmarks list will automatically update once this is property is added.

Now in the landmarks list and press the 'Mammuthus primigenius (Blumbach)' entry. 

{% include alert type="tip" content="
You can control the distance and/or position you are placed from a landmark in the `landmark` properties either with a `randomRadiusMin` and `randomRadiusMax`,
or an `offsetPosition`. Otherwise, you may be placed in the middle of the object!
"%}

![](/assets/img/overview/build/mammuthus-primigenius-scene-landmark.png)

## Link your scene to the physical world
You can make a scene you create linkable to the physical world by adding its coordinates to the [ATLAS tool](https://atlas.conix.io) (requires write permission to list coordinates). This will allow users in Augmented Reality (AR) to [discover your ARENA scene](../tools/atlas) when they are in physical range of it.

  ![](../../../assets/img/overview/atlas.png)


Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a>, <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
  {: .fs-1 }
