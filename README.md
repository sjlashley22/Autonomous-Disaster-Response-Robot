# Autonomous-Disaster-Response-Robot
Autonomous mobile robot simulation using CoppeliaSim and Lua with proximity-based obstacle detection and state-based navigation.


# Autonomous Disaster Response Robot

An autonomous mobile robot simulation developed in CoppeliaSim using
Lua. The robot uses proximity sensing and state-based navigation logic
to detect obstacles and maneuver around them without direct user input.

This project was originally developed as part of my Computer Science
coursework at Western Governors University.

## Project Overview

The goal of this project was to program an autonomous robot capable of
navigating a simulated disaster environment while responding to
obstacles in its path.

The robot uses a proximity sensor to detect nearby obstacles and a
four-wheel motor system to control its movement. When an obstacle is
detected, the controller automatically transitions through a sequence
of movement states to move away from the obstruction and continue
forward.

## Technologies and Concepts

- CoppeliaSim
- Lua
- Robotics Simulation
- Proximity Sensors
- Autonomous Navigation
- State-Based Control Logic
- Motor Control
- Sensor Integration

## Robot Controller

The robot is controlled by a Lua script using CoppeliaSim's simulation
API.

During initialization, the controller obtains references to the
robot's sensors and four wheel motors.

The primary components include:

- Proximity sensor
- Vision sensor
- Front-left wheel motor
- Front-right wheel motor
- Rear-left wheel motor
- Rear-right wheel motor

The implemented obstacle-avoidance behavior is driven by the proximity
sensor. A vision sensor is included in the simulation, but the current
navigation logic does not use vision data for decision-making.

## Navigation Logic

The controller uses three primary movement states:

1. `forward`
2. `backup`
3. `slide`

Under normal conditions, the robot remains in the `forward` state.

When the proximity sensor detects an obstacle, the controller changes
the robot's state to `backup`.

The robot then:

1. Moves backward for approximately one second.
2. Transitions to the `slide` state.
3. Moves sideways for approximately two seconds to maneuver around the
   obstacle.
4. Returns to the `forward` state and continues navigating.

This creates a simple autonomous obstacle-avoidance behavior without
requiring direct user control.

## State Flow

```text
            Obstacle Detected
                   |
                   v
FORWARD --------> BACKUP
                   |
                   | After ~1 second
                   v
                 SLIDE
                   |
                   | After ~2 seconds
                   v
                FORWARD
