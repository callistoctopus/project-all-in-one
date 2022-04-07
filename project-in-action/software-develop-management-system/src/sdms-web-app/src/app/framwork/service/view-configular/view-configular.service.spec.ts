import { TestBed } from '@angular/core/testing';

import { ViewConfigularService } from './view-configular.service';

describe('ViewConfigularService', () => {
  let service: ViewConfigularService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ViewConfigularService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
