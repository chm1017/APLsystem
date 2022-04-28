package test;

public class Person {
    private String name = "张三";
    private Integer age = 20;

    @Override
    public String toString() {
        return "Person{" +
                "name='" + name + '\'' +
                ", age=" + age +
                '}';
    }
}
