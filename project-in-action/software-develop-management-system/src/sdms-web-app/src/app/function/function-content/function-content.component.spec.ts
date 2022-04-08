import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FunctionContentComponent } from './function-content.component';

describe('FunctionContentComponent', () => {
  let component: FunctionContentComponent;
  let fixture: ComponentFixture<FunctionContentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FunctionContentComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FunctionContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
