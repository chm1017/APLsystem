package test;



import com.sun.deploy.util.StringUtils;

import java.io.File;
import java.io.FileInputStream;
import java.util.*;

//public class Test
//{
//    public static void main(String[] args) {
//        List<String> hatIdList = new ArrayList<String>();
//
//        hatIdList.add("hello");
//        hatIdList.add("world");
//        hatIdList.add("rest");
//
//        hatIdList.remove("world");
//        System.out.println(StringUtils.join(hatIdList, ","));
//    }
//
//
//
//}
public class Test {
        public static void main(String[] args) {
            // 创建一个集合
            Collection objs = new HashSet();
            objs.add("C语言中文网Java教程");
            objs.add("C语言中文网C语言教程");
            objs.add("C语言中文网C++教程");
            // 调用forEach()方法遍历集合
            // 获取books集合对应的迭代器
            Iterator it = objs.iterator();
            while (it.hasNext()) {
                // it.next()方法返回的数据类型是Object类型，因此需要强制类型转换
                String obj = (String) it.next();
                System.out.println(obj);
                if (obj.equals("C语言中文网C语言教程")) {
                    // 从集合中删除上一次next()方法返回的元素
                    it.remove();
                }
                // 对book变量赋值，不会改变集合元素本身
                obj = "C语言中文网Python语言教程";
            }
            System.out.println(objs);
        }
//        File f = new File("C:/"); // 建立File变量,并设定由f变量变数引用
//        System.out.println("文件名称\t\t文件类型\t\t文件大小");
//        System.out.println("===================================================");
//        String fileList[] = f.list(); // 调用不带参数的list()方法
//        for (int i = 0; i < fileList.length; i++) { // 遍历返回的字符数组
//            System.out.print(fileList[i] + "\t\t");
//            System.out.print((new File("C:/", fileList[i])).isFile() ? "文件" + "\t\t" : "文件夹" + "\t\t");
//            System.out.println((new File("C:/", fileList[i])).length() + "字节");
//        }

}
