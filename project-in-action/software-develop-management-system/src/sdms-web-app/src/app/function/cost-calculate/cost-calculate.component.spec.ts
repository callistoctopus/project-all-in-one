import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CostCalculateComponent } from './cost-calculate.component';

describe('CostCalculateComponent', () => {
  let component: CostCalculateComponent;
  let fixture: ComponentFixture<CostCalculateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CostCalculateComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CostCalculateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
