package com.rramalho.sum;

import org.apache.camel.Exchange;
import org.apache.camel.Message;
import org.apache.camel.component.cxf.CxfPayload;
public class Processor implements org.apache.camel.Processor {

	@Override
	public void process(Exchange ex) throws Exception {
		Message m = ex.getIn();
		CxfPayload<Object> p = (CxfPayload<Object>) m.getBody();
		ex.setOut(m);
	}

}
