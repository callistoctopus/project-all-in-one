import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import Stats from 'stats.js';
import { B } from './b';

window.onresize = function (e) {
  B1.canvas.width = window.innerWidth;
  B1.canvas.height = window.innerHeight;
};

export class B1 extends B{
  stats;
  proton;
  renderer;
  emitter = [];

  constructor() {
    super('b1');
  }

  override init2() {
    this.initCanvas();
    this.createProton();
    this.render();
  }

  // override destroy(): void {
  //   B.canvas = null;
  // }

  initStats() {
    this.stats = new Stats();
    this.stats.setMode(2);
    this.stats.domElement.style.position = 'absolute';
    this.stats.domElement.style.left = '80px';
    this.stats.domElement.style.top = '30px';
    document.body.appendChild(this.stats.domElement);
  }

  createProton() {
    this.proton = new Proton();

    for (let i = 0; i < 16; i++) {
      this.emitter[i] = new Proton.Emitter();

      this.emitter[i].rate = new Proton.Rate(
        new Proton.Span(1, 3),
        new Proton.Span(0.4, 0.3)
      );

      this.emitter[i].addInitialize(new Proton.Mass(5));
      this.emitter[i].addInitialize(new Proton.Radius(1, 2));
      this.emitter[i].addInitialize(new Proton.Life(2, 10));
      this.emitter[i].addInitialize(
        new Proton.Velocity(
          new Proton.Span(0.5, 1),
          new Proton.Span(20, 20),
          'polar'
        )
      );
      this.emitter[i].addBehaviour(new Proton.RandomDrift(3, 20, 0.05));
      this.emitter[i].addBehaviour(
        new Proton.Color('ff0000', 'random', Infinity, Proton.easeOutQuart)
      );
      this.emitter[i].addBehaviour(new Proton.Scale(1, 12));
      this.emitter[i].p.x = B1.canvas.width / 16 * (i + 1);
      this.emitter[i].p.y = B1.canvas.height;
      this.emitter[i].emit();

      this.proton.addEmitter(this.emitter[i]);
    }

    this.renderer = new Proton.CanvasRenderer(B.canvas);
    this.renderer.onProtonUpdate = () => {
      this.context.fillStyle = 'rgba(0, 0, 0, 0.1)';
      this.context.fillRect(0, 0, B1.canvas.width, B1.canvas.height);
    };
    this.proton.addRenderer(this.renderer);
  }

  render() {
    RAFManager.add(() => {
      for (let i = 0; i < 16; i++) {
        this.emitter[i].rotation = i % 2 == 0 ? 110 : -70;
      }
      this.proton.update();
    });
  }

}
