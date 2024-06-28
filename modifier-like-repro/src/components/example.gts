import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { modifier } from 'ember-modifier';
import { hash } from '@ember/helper';

import type { ModifierLike } from '@glint/template';

import registerEvent from '../modifiers/register-event.ts';

interface Signature {
  // eslint-disable-next-line @typescript-eslint/ban-types
  Args: {};
  Blocks: {
    default: [{ register: ModifierLike<RegisterModifier> }];
  };
}

interface RegisterModifier {
  Element: HTMLElement;
}

export default class Example extends Component<Signature> {
  @tracked node: HTMLElement | null = null;

  register = modifier<RegisterModifier>((element: HTMLElement) => {
    this.node = element;

    registerEvent(this.node, ['mouseenter', this.onMouseEnter]);
  });

  onMouseEnter = () => {
    console.log('Mouse entered');
  };

  <template>
    {{yield (hash register=this.register)}}
  </template>
}
