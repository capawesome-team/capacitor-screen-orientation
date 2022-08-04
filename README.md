<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>
<h3 align="center">Screen Orientation</h3>
<p align="center"><strong><code>@capawesome/capacitor-screen-orientation</code></strong></p>
<p align="center">
  Capacitor plugin to lock/unlock the screen orientation. 
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2022?style=flat-square" />
  <a href="https://github.com/capawesome-team/capacitor-screen-orientation/actions?query=workflow%3A%22CI%22"><img src="https://img.shields.io/github/workflow/status/capawesome-team/capacitor-screen-orientation/CI/main?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@capawesome/capacitor-screen-orientation"><img src="https://img.shields.io/npm/l/@capawesome/capacitor-screen-orientation?style=flat-square" /></a>
<br>
  <a href="https://www.npmjs.com/package/@capawesome/capacitor-screen-orientation"><img src="https://img.shields.io/npm/dw/@capawesome/capacitor-screen-orientation?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@capawesome/capacitor-screen-orientation"><img src="https://img.shields.io/npm/v/@capawesome/capacitor-screen-orientation?style=flat-square" /></a>
  <a href="https://github.com/capawesome-team"><img src="https://img.shields.io/badge/part%20of-capawesome-%234f46e5?style=flat-square" /></a>
</p>

## Maintainers

| Maintainer | GitHub                                    | Social                                        |
| ---------- | ----------------------------------------- | --------------------------------------------- |
| Robin Genz | [robingenz](https://github.com/robingenz) | [@robin_genz](https://twitter.com/robin_genz) |

## Sponsors

This is an MIT-licensed open source project. 
It can grow thanks to the support by these awesome people. 
If you'd like to join them, please read more [here](https://github.com/sponsors/capawesome-team).  

<!-- sponsors --><!-- sponsors -->

## Installation

```bash
npm install @capawesome/capacitor-screen-orientation
npx cap sync
```

### iOS

On iOS you must add the following to your app's `AppDelegate.swift`:

```diff
+ import CapawesomeCapacitorScreenOrientation

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
import { ScreenOrientation, OrientationType } from '@capawesome/capacitor-screen-orientation';

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
* [`addListener('screenOrientationChange', ...)`](#addlistenerscreenorientationchange)
* [`removeAllListeners()`](#removealllisteners)
* [Interfaces](#interfaces)
* [Type Aliases](#type-aliases)
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


### addListener('screenOrientationChange', ...)

```typescript
addListener(eventName: 'screenOrientationChange', listenerFunc: ScreenOrientationChangeListener) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Listen for screen orientation changes.

| Param              | Type                                                                                        |
| ------------------ | ------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'screenOrientationChange'</code>                                                      |
| **`listenerFunc`** | <code><a href="#screenorientationchangelistener">ScreenOrientationChangeListener</a></code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

Remove all listeners for this plugin.

--------------------


### Interfaces


#### LockOptions

| Prop       | Type                                                        | Description                |
| ---------- | ----------------------------------------------------------- | -------------------------- |
| **`type`** | <code><a href="#orientationtype">OrientationType</a></code> | The orientation lock type. |


#### GetCurrentOrientationResult

| Prop       | Type                                                        | Description                   |
| ---------- | ----------------------------------------------------------- | ----------------------------- |
| **`type`** | <code><a href="#orientationtype">OrientationType</a></code> | The current orientation type. |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### ScreenOrientationChange

| Prop       | Type                                                        | Description                   |
| ---------- | ----------------------------------------------------------- | ----------------------------- |
| **`type`** | <code><a href="#orientationtype">OrientationType</a></code> | The current orientation type. |


### Type Aliases


#### ScreenOrientationChangeListener

Callback to receive the screen orientation change notifications.

<code>(change: <a href="#screenorientationchange">ScreenOrientationChange</a>): void</code>


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

See [CHANGELOG.md](https://github.com/capawesome-team/capacitor-screen-orientation/blob/master/CHANGELOG.md).

## License

See [LICENSE](https://github.com/capawesome-team/capacitor-screen-orientation/blob/master/LICENSE).
