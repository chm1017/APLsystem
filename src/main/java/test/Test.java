package test;

import java.util.ArrayList;

public class Test {
    public static void main(String[] args) {
        ArrayList<String> list = new ArrayList<>(10);
        list.add("a");
        list.add("b");
        list.add("c");
        int i = 0;
        for (String s : list) {
            System.out.println(s+"=========="+(++i));
        }
        System.out.println("hello world");
    }


}
