package com.cm.APL.workbench.domain;


public class Product {
    //这是每次添加产品用的
               private String pid;
               private String pname;
               private String createDate;
               private String endDate;
               private String mid;
               private Integer number;
               private Double price;
               private String paddress;
               private String description;
               private String createBy;

    @Override
    public String toString() {
        return "Product{" +
                "pid='" + pid + '\'' +
                ", pname='" + pname + '\'' +
                ", createDate='" + createDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", mid='" + mid + '\'' +
                ", number=" + number +
                ", price=" + price +
                ", paddress='" + paddress + '\'' +
                ", description='" + description + '\'' +
                ", createBy='" + createBy + '\'' +
                '}';
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getMerchant() {
        return mid;
    }

    public void setMerchant(String mid) {
        this.mid = mid;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getPaddress() {
        return paddress;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public void setPaddress(String paddress) {
        this.paddress = paddress;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
}
