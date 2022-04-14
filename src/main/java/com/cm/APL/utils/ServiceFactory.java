package com.cm.APL.utils;

public class ServiceFactory {
	
	public static Object getService(Object service){
		
		return new TransactionInvocationHandler(service).getProxy();
		
	}
	
}
