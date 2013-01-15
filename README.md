# Disc Collision

A distance based collision detection system, dubbed Disc Collision. A very basic model for collision detection, but also very fast in comparison to the vector based hitTest() in the Flash API. 

Collisions are detected by a request-only model. The collision detection simply manages a collection of points and distances associated with each point. So you could easily put this into your a game engine and run an update call to get colliding points. 

The algorithm is robust and has a few things to optimize. The collection of points is subdivided into multiple lists according to a spatial grid. To reduce the amount of work required detection. Then all of our points are sorted through a BST by distance so that we always know the largest distance to use when selecting grid sections. 

Hold the red button down below to create objects to test collisions. 

