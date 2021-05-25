---
title: A-Frame
nav_order: 5
layout: default
parent: Developers
---

# A-Frame
- [https://aframe.io/](https://aframe.io/)

{% include alert type="warning" title="Warning" content="The code examples below are currently out of date and are being updated..." %}

## Adding Arbitrary A-Frame to the ARENA

The `data` payload we send in MQTT messages is _both_ a part of A-Frame and used especially by the ARENA. When the ARENA generates an A-Frame `<a-entity>` we parse known ARENA-specific parts of the payload first, then what remains goes into attributes.

In ARENA-core `mqtt.js` ~line 984:

```javascript
// what remains are attributes for special cases; iteratively set them
const thing = Object.entries(theMessage.data);
const len = thing.length;
for (let i = 0; i < len; i++) {
  const theattr = thing[i][0]; // attribute
  const thevalue = thing[i][1]; // value
  entityEl.setAttribute(theattr, thevalue);
}
```

Example:

```json
python3 -m arena -a pub -mh arenaxr.org -t realm/s/public/example/duck_1 -m '{ "object_id" : "duck_1", "action": "update", "type": "object", "data": { "animation": { "property": "rotation", "to": "0 360 0", "loop": true, "dur": 10000 } } }'
```

{% include alert type="warning" title="Coming Soon" content="Stay tuned for more details..." %}
