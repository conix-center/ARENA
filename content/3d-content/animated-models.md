---
title: Animated Models
nav_order: 5
layout: default
parent: 3D Content
---

# Animated Models

{% include alert type="warning" title="Warning" content="The code examples below are currently out of date and are being updated..." %}

## Animate (rotation)

Animate rotation of the already drawn cube.

Raw Message

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/cube_1 -m '{"object_id" : "cube_1", "action": "update", "type": "object", "data": { "animation": { "property": "rotation", "to": "0 360 0", "loop": true, "dur": 10000}} }'
```

Python

```python
cube.update(data='{"animation": {"property":"rotation", "to":"0 360 0", "loop":"true", "dur":10000}}')
```

other animations are available that resemble the `"data": {"animation": { "property": ... }}` blob above: see [A-Frame Animation](https://aframe.io/docs/1.0.0/components/animation.html) documentation for more examples
