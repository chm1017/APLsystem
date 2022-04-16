package com.cm.APL.workbench.domain;

public class OrderId {
    private String  id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "OrderId{" +
                "id='" + id + '\'' +
                '}';
    }
}
