package cn.think.sky.rpc.httpinvoker.exportservice;

import org.springframework.stereotype.Service;

@Service
public class ExportServiceImpl implements ExportService{
	
	static int i = 0;
	
	public int getSomething() {
		return i++;
	}

}
