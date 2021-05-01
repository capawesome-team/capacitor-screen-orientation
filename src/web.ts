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
    await screen.orientation.lock(options.type);
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
    switch (screen.orientation.type) {
      case 'landscape-primary':
        return { type: OrientationType.LANDSCAPE_PRIMARY };
      case 'landscape-secondary':
        return { type: OrientationType.LANDSCAPE_SECONDARY };
      case 'portrait-primary':
        return { type: OrientationType.PORTRAIT_PRIMARY };
      case 'portrait-secondary':
        return { type: OrientationType.PORTRAIT_SECONDARY };
      default:
        throw new Error('The current orientation type could not be detected.');
    }
  }

  private throwUnsupportedError(): never {
    throw this.unavailable(
      'Screen Orientation API not available in this browser.',
    );
  }
}
