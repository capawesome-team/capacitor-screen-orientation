<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>
<h3 align="center">Screen Orientation</h3>
<p align="center"><strong><code>@robingenz/capacitor-screen-orientation</code></strong></p>
<p align="center">
  Capacitor plugin to lock/unlock the screen orientation. 
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2021?style=flat-square" />
  <a href="https://github.com/robingenz/capacitor-screen-orientation/actions?query=workflow%3A%22CI%22"><img src="https://img.shields.io/github/workflow/status/robingenz/capacitor-screen-orientation/CI/main?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@robingenz/capacitor-screen-orientation"><img src="https://img.shields.io/npm/l/@robingenz/capacitor-screen-orientation?style=flat-square" /></a>
<br>
  <a href="https://www.npmjs.com/package/@robingenz/capacitor-screen-orientation"><img src="https://img.shields.io/npm/dw/@robingenz/capacitor-screen-orientation?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@robingenz/capacitor-screen-orientation"><img src="https://img.shields.io/npm/v/@robingenz/capacitor-screen-orientation?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<a href="#contributors-"><img src="https://img.shields.io/badge/all%20contributors-1-orange?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:END -->
</p>

## Maintainers

| Maintainer | GitHub                                    | Social                                        |
| ---------- | ----------------------------------------- | --------------------------------------------- |
| Robin Genz | [robingenz](https://github.com/robingenz) | [@robin_genz](https://twitter.com/robin_genz) |

## Installation

```bash
npm install @robingenz/capacitor-screen-orientation
npx cap sync
```

### iOS

On iOS you must add the following to your app's `AppDelegate.swift`:

```diff
+ import RobingenzCapacitorScreenOrientation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

+ func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
+   return ScreenOrientation.getSupportedInterfaceOrientations()
+ }
```

## Configuration

No configuration required for this plugin.

## Demo

A working example can be found here: [robingenz/capacitor-plugin-demo](https://github.com/robingenz/capacitor-plugin-demo)

## Usage

```typescript
import { ScreenOrientation, OrientationType } from '@robingenz/capacitor-screen-orientation';

const lock = async () => {
  await ScreenOrientation.lock({ type: OrientationType.LANDSCAPE });
};

const unlock = async () => {
  await ScreenOrientation.unlock();
};

const getCurrentOrientation = async () => {
  const result = await ScreenOrientation.getCurrentOrientation();
  return result.type;
};
```

## API

<docgen-index>

* [`lock(...)`](#lock)
* [`unlock()`](#unlock)
* [`getCurrentOrientation()`](#getcurrentorientation)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### lock(...)

```typescript
lock(options: LockOptions) => Promise<void>
```

Locks the device orientation.

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#lockoptions">LockOptions</a></code> |

--------------------


### unlock()

```typescript
unlock() => Promise<void>
```

Unlocks the device orientation.

--------------------


### getCurrentOrientation()

```typescript
getCurrentOrientation() => Promise<GetCurrentOrientationResult>
```

Gets the current device orientation type.

**Returns:** <code>Promise&lt;<a href="#getcurrentorientationresult">GetCurrentOrientationResult</a>&gt;</code>

--------------------


### Interfaces


#### LockOptions

| Prop       | Type                                                        | Description                |
| ---------- | ----------------------------------------------------------- | -------------------------- |
| **`type`** | <code><a href="#orientationtype">OrientationType</a></code> | The orientation lock type. |


#### GetCurrentOrientationResult

| Prop       | Type                                                        | Description                |
| ---------- | ----------------------------------------------------------- | -------------------------- |
| **`type`** | <code><a href="#orientationtype">OrientationType</a></code> | The orientation lock type. |


### Enums


#### OrientationType

| Members                   | Value                              | Description                                                         |
| ------------------------- | ---------------------------------- | ------------------------------------------------------------------- |
| **`LANDSCAPE`**           | <code>'landscape'</code>           | The orientation is either landscape-primary or landscape-secondary. |
| **`LANDSCAPE_PRIMARY`**   | <code>'landscape-primary'</code>   | The orientation is in the primary landscape mode.                   |
| **`LANDSCAPE_SECONDARY`** | <code>'landscape-secondary'</code> | The orientation is in the secondary landscape mode.                 |
| **`PORTRAIT`**            | <code>'portrait'</code>            | The orientation is either portrait-primary or portrait-secondary.   |
| **`PORTRAIT_PRIMARY`**    | <code>'portrait-primary'</code>    | The orientation is in the primary portrait mode.                    |
| **`PORTRAIT_SECONDARY`**  | <code>'portrait-secondary'</code>  | The orientation is in the secondary portrait mode.                  |

</docgen-api>

## Changelog

See [CHANGELOG.md](https://github.com/robingenz/capacitor-screen-orientation/blob/master/CHANGELOG.md).

## License

See [LICENSE](https://github.com/robingenz/capacitor-screen-orientation/blob/master/LICENSE).
