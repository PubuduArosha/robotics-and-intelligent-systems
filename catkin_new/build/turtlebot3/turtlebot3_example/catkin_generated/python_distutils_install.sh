#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/pubudu/catkin_new/src/turtlebot3/turtlebot3_example"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/pubudu/catkin_new/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/pubudu/catkin_new/install/lib/python2.7/dist-packages:/home/pubudu/catkin_new/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/pubudu/catkin_new/build" \
    "/usr/bin/python2" \
    "/home/pubudu/catkin_new/src/turtlebot3/turtlebot3_example/setup.py" \
     \
    build --build-base "/home/pubudu/catkin_new/build/turtlebot3/turtlebot3_example" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/pubudu/catkin_new/install" --install-scripts="/home/pubudu/catkin_new/install/bin"
