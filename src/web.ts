import { WebPlugin } from '@capacitor/core';

import type {
  GetCurrentTypeResult,
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
    await screen.orientation.lock(options.type);
  }

  public async unlock(): Promise<void> {
    if (!this.isSupported) {
      this.throwUnsupportedError();
    }
    screen.orientation.unlock();
  }

  public async getCurrentOrientationType(): Promise<GetCurrentTypeResult> {
    if (!this.isSupported) {
      this.throwUnsupportedError();
    }
    let currentType = OrientationType.LANDSCAPE_PRIMARY;
    switch (screen.orientation.type) {
      case 'landscape-secondary':
        currentType = OrientationType.LANDSCAPE_SECONDARY;
        break;
      case 'portrait-primary':
        currentType = OrientationType.PORTRAIT_PRIMARY;
        break;
      case 'portrait-secondary':
        currentType = OrientationType.PORTRAIT_SECONDARY;
        break;
    }
    return { type: currentType };
  }

  private throwUnsupportedError(): never {
    throw this.unavailable(
      'Screen Orientation API not available in this browser.',
    );
  }
}
