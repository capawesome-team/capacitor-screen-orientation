export interface ScreenOrientationPlugin {
  lock(options: LockOptions): Promise<void>;
  unlock(): Promise<void>;
  getCurrentOrientationType(): Promise<GetCurrentTypeResult>;
}

export interface LockOptions {
  /**
   * The orientation lock type.
   */
  type: OrientationType;
}

export interface GetCurrentTypeResult {
  type: OrientationType;
}

export enum OrientationType {
  LANDSCAPE = 'landscape',
  LANDSCAPE_PRIMARY = 'landscape-primary',
  LANDSCAPE_SECONDARY = 'landscape-secondary',
  PORTRAIT = 'portrait',
  PORTRAIT_PRIMARY = 'portrait-primary',
  PORTRAIT_SECONDARY = 'portrait-secondary',
}
