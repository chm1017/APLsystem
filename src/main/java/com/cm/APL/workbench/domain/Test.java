package com.cm.APL.workbench.domain;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Test {
    public static void main(String[] args) throws IOException {

            //定义两个字符串
            String OneStr = "ckkccbacadkabckebfkabkskabcabc";
            String ToStr = "abc";
            //获取两个字符串的长度
            int OneLength = OneStr.length();
            int ToLength = ToStr.length();
            //定义两个整数，count记录出现的次数、index记录每次找到一个以后位置
            int count = 0;
            int index = 0;
            //if判断查找的字符串与总字符串的长度，如果查找的字符串较长，则直接输出0
            //while循环查找指定字符串在总字符串中出现的次数
            if (OneLength >= ToLength) {
                while ((index = OneStr.indexOf(ToStr, index)) != -1) {
                    count++;
                    index += ToLength;
                }
            }
            System.out.println(count);


    }

    public void getAnswer(String star) {

        String ToStr = "Startimes";

        int OneLength = star.length();
        int ToLength = ToStr.length();
        int count = 0;
        int index = 0;
        if (OneLength >= ToLength) {
            while ((index = star.indexOf(ToStr, index)) != -1) {
                count++;
                index += ToLength;
            }
        }
        if (count % 2 == 0) {
            System.out.println("mee Fail");
        } else {
            System.out.println("Startimestmee Success");
        }
    }

    public void getCount(String[] strings, Integer money) {

    }
}
