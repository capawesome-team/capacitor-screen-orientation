export interface ScreenOrientationPlugin {
  lock(options: LockOptions): Promise<void>;
  unlock(): Promise<void>;
  getCurrentOrientation(): Promise<GetCurrentOrientationResult>;
}

export interface LockOptions {
  orientation: OrientationType;
}

export interface GetCurrentOrientationResult {
  orientation: OrientationType;
}

export enum OrientationType {
  ANY = 'any',
  LANDSCAPE = 'landscape',
  LANDSCAPE_PRIMARY = 'landscape-primary',
  LANDSCAPE_SECONDARY = 'landscape-secondary',
  PORTRAIT = 'portrait',
  PORTRAIT_PRIMARY = 'portrait-primary',
  PORTRAIT_SECONDARY = 'portrait-secondary',
}
