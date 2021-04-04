export interface ScreenOrientationPlugin {
  lock(options: LockOptions): Promise<void>;
  unlock(): Promise<void>;
}

export interface LockOptions {
  orientation: LockTypes;
}

export enum LockTypes {
  ANY = 'any',
  NATURAL = 'natural',
  LANDSCAPE = 'landscape',
  PORTRAIT = 'portrait',
  PORTRAIT_PRIMARY = 'portrait-primary',
  PORTRAIT_SECONDARY = 'portrait-secondary',
  LANDSCAPE_PRIMARY = 'landscape-primary',
  LANDSCAPE_SECONDARY = 'landscape-secondary',
}
