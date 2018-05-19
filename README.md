# isomorphisms

[![Build Status](https://travis-ci.com/doersino/isomorphisms.svg?token=zqGLmNq38muyM7XHMUFU&branch=master)](https://travis-ci.com/doersino/isomorphisms)

Code shown in my [blog post "Isomorphisms Between Integers and Some Composite Types in Haskell"](https://hejnoah.com/posts/isomorphisms.html).

## Setup & Usage

```
git clone https://github.com/doersino/isomorphisms.git
cd isomorphisms
stack build && stack exec isomorphisms  # see haskellstack.org
```

Expected output (after the usual build status messages):

```
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
+++ OK, passed 100 tests.
*** Failed! Falsifiable (after 2 tests):
1
*** Failed! Falsifiable (after 8 tests and 8 shrinks):
[0,0,0,3]
```

The last two tests fail for the reasons [detailed in the post](https://hejnoah.com/posts/isomorphisms.html). You should go read it!
