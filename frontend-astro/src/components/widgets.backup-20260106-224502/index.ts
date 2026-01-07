// Widget Registry - Safe widget system
export const WIDGET_REGISTRY = {
  'image-overlay': () => import('./HeroImageOverlay.astro'),
  // Future widgets can be added here safely
  // 'dynamic-cards': () => import('./DynamicCards.astro'),
  // 'custom-widget': () => import('./CustomWidget.astro'),
};

export type WidgetVariant = keyof typeof WIDGET_REGISTRY;

export const isRegisteredWidget = (variant: string): variant is WidgetVariant => {
  return variant in WIDGET_REGISTRY;
};