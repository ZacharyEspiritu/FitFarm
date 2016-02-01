# FitFarm
**3rd place** at hackTrin III by Nicholas Cimaszewski, Zachary Espiritu, and Vincent McAuliffe. A fitness-based farm management simulator where players raise their own farm through real-world physical exercise.

## Inspiration
We hate working out and we hate Farmville. Let's find out if two wrongs make a right!

## What it does
FitFarm is a fitness-based farm management simulator where players raise their own farm by earning CardioCoins which are gained through real-world physical exercise. Every time a player checks into the app, FitFarm checks the HealthKit interface on the iPhone to see if new steps have been logged (which are counted via the Apple Watch), and converts them on a 1:1 ratio to CardioCoins which can then be used to feed animals and buy supplies to help their farm grow.

## How we built it
We built FitFarm using HealthKit, Apple's interface for accessing health data on iPhones, the open-source game engine cocos2d-objc and the programming languages Swift and Objective-C. We also used Sketch and Photoshop to create the artwork (except for the animals).

## Challenges we ran into
HealthKit is really unreliable at querying the Apple Watch every so often in order to log new steps. It can take a very long time for steps to show up in the iPhone.

## Accomplishments that we're proud of
The design of the user interface (especially considering we created it in under 8 hours) and finally figuring out how to use HealthKit.

## What we learned
We figured out how to use HealthKit and why not to ever use HealthKit again. We also became more experienced in the art of Photoshop and Sketch for rapid artwork iteration, and we also learned how to use Git in a collaborative setting.

## What's next for FitFarm
We're looking to add a feature where you can visit other people's farms and leave notes of encouragement, and then possibly introducing new forms of currency based off of the HealthKit features, such as heart rate or calories burned.

**Devpost Link:** http://devpost.com/software/fitfarm-3f7wxu
