package com.property.ssm.util;

import java.text.DecimalFormat;

public class DeFormat {
	public static Double DoubleFormat(Double num) {
		if(num==null) {
			return null;
		}
		DecimalFormat df = new DecimalFormat(".##");
		String s = df.format(num);
		try {
			Double n = Double.valueOf(s);
			return n;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
}
