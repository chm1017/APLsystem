package test;

import java.sql.Array;
import java.util.*;
import java.util.function.IntBinaryOperator;
import java.util.function.IntUnaryOperator;


public class PlayString {
    public static void main(String[] args) {


        Integer[] a = { 9, 8, 7, 2, 3, 4, 1, 0, 6, 5 };
        // 数组类型为Integer
        Arrays.sort(a, Collections.reverseOrder());
        for (int arr : a) {
            System.out.print(arr + " ");
        }

        int[] arr1 = new int[] { 3, 4, 25, 16, 30, 18 };
        // 对数组arr1进行并发排序
        Arrays.parallelSort(arr1);
        System.out.println(Arrays.toString(arr1));
        Arrays.parallelPrefix(arr1, new IntBinaryOperator() {
            @Override
            public int applyAsInt(int left, int right) {
                return left + right;
            }
        });
        System.out.println(Arrays.toString(arr1));
        Arrays.fill(arr1, 9);
        Arrays.parallelSetAll(arr1, new IntUnaryOperator() {
            @Override
            public int applyAsInt(int operand) {
                return operand*6;
            }
        });
        System.out.println(Arrays.toString(arr1));


        int[] iint = new int[10];
        for (int i = 0; i < iint.length; i++) {
            System.out.println(iint[i]);
        }

        Arrays.fill(iint, 1);
        for (int i = 0; i < iint.length; i++) {
            System.out.println(iint[i]);
        }
        System.out.println();


        Properties properties = System.getProperties();


        Person person = new Person();
        System.out.println(person.toString());
        System.out.println(person.getClass());
        Class c = Integer.TYPE;
        System.out.println(c);

        Calendar instance = Calendar.getInstance();
        instance.setTime(new Date());
        System.out.println(instance);
        Date date = new Date();
        System.out.println(date.toString());

        double r = 2.4;
        System.out.println(Math.rint(r));
        System.out.println(Math.round(r));

    }
}
