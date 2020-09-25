package book.mngt.controller;

import java.util.ArrayList;
import java.util.Collections;

public class test {
	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList<String>();
		
		list.add("HN");
		list.add("HUE");
		list.add("DANANG");
		list.add("SAIGON");
		
		Collections.sort(list);
		
		for (String string : list) {
			System.out.println(string);
		}
	}
}
