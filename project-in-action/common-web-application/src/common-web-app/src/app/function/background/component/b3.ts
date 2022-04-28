import Proton from 'proton-engine';
import RAFManager from 'raf-manager';
import { B } from './b';

export class B3 extends B {
  destory() {
    ;
  }

  constructor() {
    super('b3');
  }

  init() {
    // as HTMLCanvasElement
    const canvas = document.getElementById('canvas') as HTMLCanvasElement;
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    let context = canvas.getContext('2d');

    //////////////////////

    let proton = new Proton();

    let emitter = new Proton.Emitter();
    emitter.rate = new Proton.Rate(
      Proton.getSpan(150),
      Proton.getSpan(0.05, 0.2)
    );
    emitter.addInitialize(new Proton.Mass(50));
    emitter.addInitialize(new Proton.Radius(1, 4));
    emitter.addInitialize(new Proton.Life(Infinity));
    emitter.addInitialize(new Proton.Position(
      new Proton.RectZone(0, 0, canvas.width, canvas.height)
    ));
    emitter.addInitialize(
      new Proton.Velocity(
        new Proton.Span(0.05, 0.1),
        new Proton.Span(0, 360),
        "polar"
      )
    );

    emitter.addBehaviour(new Proton.Alpha(Proton.getSpan(0.2, 0.9)));
    emitter.addBehaviour(new Proton.Color("#ffffff"));
    emitter.addBehaviour(
      new Proton.CrossZone(
        new Proton.RectZone(0, 0, canvas.width, canvas.height),
        "cross"
      )
    );

    emitter.emit("once");
    emitter.damping = 0;
    proton.addEmitter(emitter);

    //////////////////////////

    const R = 150;
    let renderer = new Proton.CanvasRenderer(canvas);
    renderer.onProtonUpdateAfter = () => {
      const particles = emitter.particles;
      for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
          const pA = particles[i];
          const pB = particles[j];
          const dis = pA.p.distanceTo(pB.p);

          if (dis < R) {
            const alpha = (1 - dis / R) * 0.5;
            context.strokeStyle = "rgba(255,255,255," + alpha + ")";
            context.beginPath();
            context.moveTo(pA.p.x, pA.p.y);
            context.lineTo(pB.p.x, pB.p.y);
            context.closePath();
            context.stroke();
          }
        }
      }
    };

    proton.addRenderer(renderer);
    /////////////////////

    RAFManager.add(() => {
      proton.update();
    });
  }

}
