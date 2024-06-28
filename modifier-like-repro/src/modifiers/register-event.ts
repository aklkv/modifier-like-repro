import { modifier } from 'ember-modifier';

interface RegisterEventSignature {
  Element: HTMLElement;
  Args: {
    Positional: [keyof ElementEventMap, EventListener];
    Named: { useCapture?: boolean };
  };
}

export default modifier<RegisterEventSignature>(
  (element, positional, named = {}) => {
    const targetElement = element;

    const [event, eventHandler] = positional;

    const { useCapture = false } = named;

    targetElement.addEventListener(event, eventHandler, useCapture);

    return () => {
      targetElement.removeEventListener(event, eventHandler, useCapture);
    };
  },
);
