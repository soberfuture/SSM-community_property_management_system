package com.property.ssm.util;

public class StringToInt {

	public static int[] StringtoInt(String str,String split) throws Exception{
		String a[] = str.split(" ");
		int[] id = new int[a.length];
		for(int i=0;i<id.length;i++) {
			id[i]=Integer.parseInt(a[i]);
		}
		return id;
	}
	
}
