package com.cm.APL.workbench.domain;

public class Order {
            private String id;
            private String pname;
            private Double price;
            private String createDate;
            private Integer count;
            private String oid;
            private Double totalprice;
            private String mname;
            private String paddress;
            private String pid;

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id='" + id + '\'' +
                ", pname='" + pname + '\'' +
                ", price=" + price +
                ", createDate='" + createDate + '\'' +
                ", count=" + count +
                ", oid='" + oid + '\'' +
                ", totalprice=" + totalprice +
                ", mname='" + mname + '\'' +
                ", paddress='" + paddress + '\'' +
                ", pid='" + pid + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public Double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(Double totalprice) {
        this.totalprice = totalprice;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getPaddress() {
        return paddress;
    }

    public void setPaddress(String paddress) {
        this.paddress = paddress;
    }
}
