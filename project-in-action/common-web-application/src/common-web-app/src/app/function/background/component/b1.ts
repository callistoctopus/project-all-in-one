import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import { B } from './b';

export class B1 extends B {

  constructor() {
    super('b1');
  }

  destory() { }

  init() {
    const canvas = document.getElementById('canvas') as HTMLCanvasElement;
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    let context = canvas.getContext('2d');

    let proton = new Proton();

    let emitter = [];

    for (let i = 0; i < 16; i++) {
      emitter[i] = new Proton.Emitter();

      emitter[i].rate = new Proton.Rate(
        new Proton.Span(1, 3),
        new Proton.Span(0.4, 0.3)
      );

      emitter[i].addInitialize(new Proton.Mass(5));
      emitter[i].addInitialize(new Proton.Radius(1, 2));
      emitter[i].addInitialize(new Proton.Life(2, 10));
      emitter[i].addInitialize(
        new Proton.Velocity(
          new Proton.Span(0.5, 1),
          new Proton.Span(20, 20),
          'polar'
        )
      );
      emitter[i].addBehaviour(new Proton.RandomDrift(3, 20, 0.05));
      emitter[i].addBehaviour(
        new Proton.Color('ff0000', 'random', Infinity, Proton.easeOutQuart)
      );
      emitter[i].addBehaviour(new Proton.Scale(1, 12));
      emitter[i].p.x = canvas.width / 16 * (i + 1);
      emitter[i].p.y = canvas.height;
      emitter[i].emit();

      proton.addEmitter(emitter[i]);
    }

    let renderer = new Proton.CanvasRenderer(canvas);
    renderer.onProtonUpdate = () => {
      context.fillStyle = 'rgba(0, 0, 0, 0.1)';
      context.fillRect(0, 0, canvas.width, canvas.height);
    };
    proton.addRenderer(renderer);

    RAFManager.add(() => {
      for (let i = 0; i < 16; i++) {
        emitter[i].rotation = i % 2 == 0 ? 110 : -70;
      }
      proton.update();
    });
  }
}
