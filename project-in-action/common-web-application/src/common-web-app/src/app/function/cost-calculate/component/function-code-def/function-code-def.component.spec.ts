import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FunctionCodeDefComponent } from './function-code-def.component';

describe('FunctionCodeDefComponent', () => {
  let component: FunctionCodeDefComponent;
  let fixture: ComponentFixture<FunctionCodeDefComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FunctionCodeDefComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FunctionCodeDefComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
