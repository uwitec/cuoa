package com.oa.framework.utils.file;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class CmdExec {

	public static Boolean exec(String cmdline) {
		try {
			System.out.println("::: EXEC: " + cmdline);
			String line;
			Process p = null;
			if (p != null) {
				p.destroy();
				p = null;
			}
			p = Runtime.getRuntime().exec(cmdline);
			BufferedReader input = new BufferedReader(new InputStreamReader(p
					.getInputStream()));
			line = input.readLine();
			while (line != null) {
				line = input.readLine();
			}
			input.close();
			p.waitFor();
			int ret = p.exitValue();
		} catch (Exception err) {
			err.printStackTrace();
		}
		return Boolean.TRUE;
	}
}
