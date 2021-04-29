import { WebPlugin } from '@capacitor/core';

import type {
  GetCurrentOrientationResult,
  LockOptions,
  ScreenOrientationPlugin,
} from './definitions';
import { OrientationType } from './definitions';

export class ScreenOrientationWeb
  extends WebPlugin
  implements ScreenOrientationPlugin {
  private readonly isSupported = 'orientation' in screen;

  public async lock(options: LockOptions): Promise<void> {
    if (!this.isSupported) {
      this.throwUnsupportedError();
    }
    await screen.orientation.lock(options.orientation);
  }

  public async unlock(): Promise<void> {
    if (!this.isSupported) {
      this.throwUnsupportedError();
    }
    screen.orientation.unlock();
  }

  public async getCurrentOrientation(): Promise<GetCurrentOrientationResult> {
    if (!this.isSupported) {
      this.throwUnsupportedError();
    }
    let currentOrientation = OrientationType.LANDSCAPE_PRIMARY;
    switch (screen.orientation.type) {
      case 'landscape-secondary':
        currentOrientation = OrientationType.LANDSCAPE_SECONDARY;
        break;
      case 'portrait-primary':
        currentOrientation = OrientationType.PORTRAIT_PRIMARY;
        break;
      case 'portrait-secondary':
        currentOrientation = OrientationType.PORTRAIT_SECONDARY;
        break;
    }
    const result = { orientation: currentOrientation };
    return result;
  }

  private throwUnsupportedError(): never {
    throw this.unavailable(
      'Screen Orientation API not available in this browser.',
    );
  }
}
