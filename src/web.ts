import { WebPlugin } from '@capacitor/core';
import type { LockOptions, ScreenOrientationPlugin } from './definitions';

export class ScreenOrientationWeb
  extends WebPlugin
  implements ScreenOrientationPlugin {
  public async lock(options: LockOptions): Promise<void> {
    await window.screen.orientation.lock(options.orientation);
  }

  public async unlock(): Promise<void> {
    window.screen.orientation.unlock();
  }
}
