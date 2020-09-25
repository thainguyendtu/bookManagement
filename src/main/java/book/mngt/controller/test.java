package book.mngt.controller;

import java.util.ArrayList;
import java.util.Collections;

public class test {
	public static void main(String[] args) {
		int[] arrParent = {1,2,3,4,5,6};
		int[] arrChild = {2,6};
		
		int position = 0;
		
		for (int i = 0; i < arrChild.length; i++) {
			for (int j = 0; j < arrParent.length; j++) {
				if (arrParent[j] == arrChild[i]) {
					position = j;
				} else {
					position = -1;
				}
			}
		}
	}
}
