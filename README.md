# require-spaces

**require-spaces** is an extension for ``require()`` that allows you to create aliases (I call it **spaces**...) for recurrent paths in your project, and use them when *require* scripts instead of write the entire path to files.

You can install it doing ``npm install require-spaces``.  
I hope you find it useful.

## Example:
```javascript
// This is a long path in our project to a
// temporal folder in the user's home:
require('~/.app/assets/tmp/tiles/table');

// If we set "tmp" to "~/.app/assets/tmp"
// the final route is:
require('tmp::tiles/table');
```

## How to use:
#### Setup
One time ``require`` and setup:
```javascript

// You only need to require "require-spaces" once
require('require-spaces').config({
   base: 'foo/bar',
   tmp: '~/.app/assets/tmp'
});
```

You can call ``config`` again to change your spaces:
```javascript
var requireSpaces = require('require-spaces');

// This takes an object with the pairs "space-name": "space-path"
requireSpaces.config({
   base: 'foo/bSr',
   tmp: '~/.app/assets/tmp'
});

// Ups... again
requireSpaces.config({
   base: 'foo/bar',
   tmp: '~/.app/assets/tmp'
});
```

#### Using
Spaces are prefixed to the path with **the space name** and **two colons**.
```javascript
require('iamthekey::i/am/the/path');
```

#### Security concerns
You cannot write a path that goes higher in the tree than the space path.  
If this seems chinese, let's see and example:
```javascript
require('require-spaces').config({
   home: '/home/barack'
});

require('home::../../uglyVirus.js');  //--> throws an error
require('home::documents/../../../uglyVirus.js');  //--> throws an error
```

## License:
**The MIT License (MIT)**

**Copyright (c) 2016 Juande Martos (bumxu.com)**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
